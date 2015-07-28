require 'jekyll'
require 'net/http'
require 'uri'
require 'json'
require 'securerandom'
require 'pp'
require 'simple_oauth'

class PublishToTumblr < Jekyll::Generator
  def generate(site)
    if !TumblrConnection.available?
      warn("Missing Tumblr OAuth Tokens in ENV. Will not attempt to publish to Tumblr.")
      return nil
    end
    published = []

    # Filter only the posts meant to be published without tumblr id's
    tumblelog = site.categories["tumblelog"]
    tumblelog.select(&:published?).reject {|p| p.data.key?("tumblr_id") }.each do |post|
      # Publish the post to Tumblr according to the post type
      puts "Publishing #{post.id}"
      post_defaults = {
        date: post.date,
        slug: post.slug,
        format: markdown?(site, post) ? "markdown" : "html",
        # See: https://groups.google.com/forum/#!topic/tumblr-api/2E_rGjl9PE4
        source_url: "#{site.config['url']}#{post.url}",
        state: post.is_a?(Jekyll::Draft) ? "draft" : "queue" # Guard against my own foolishness.
      }
      response = case post.data["type"]
        when "photo", "quote", "link", "chat", "audio", "video"
          {}
        else # text
          tumblr_client.publish post_defaults.merge({ title: post.data["title"], body: post.to_s })
        end
      if response["status"] || !response.has_key?("id")
        abort "Encountered an error when attempting to publish to Tumblr. Aborting.\n\t#{response.to_json}"
      else
        post.data["tumblr_id"] = response["id"]
        File.open(File.join(site.source, post.path), "w") do |file|
          file.write "#{post.data.to_yaml}---\n\n#{post.to_s}"
        end
        published << post
        puts "Success. Updated #{post.path} to reflect changes."
      end
    end

    abort "Updated #{published.count} post(s)." unless published.empty?
  end

  def markdown?(site, post)
    extensions = site.config["markdown_ext"].split(",").map {|e| ".#{e.downcase}"}
    extensions.include? post.ext
  end

  def tumblr_client
    @tumblr_client ||= TumblrConnection.new
  end
end

class TumblrConnection
  HOST = "mwunsch.tumblr.com"
  POST_URI = URI("https://api.tumblr.com/v2/blog/#{HOST}/post")
  USER_INFO = URI("https://api.tumblr.com/v2/user/info")
  OAUTH_VARS = %w( TUMBLR_CONSUMER_KEY
                   TUMBLR_CONSUMER_SECRET
                   TUMBLR_OAUTH_TOKEN
                   TUMBLR_OAUTH_TOKEN_SECRET ).map {|v| ::ENV.assoc(v) }

  def self.available?
    OAUTH_VARS.all?
  end

  def initialize
    @oauth = OAUTH_VARS.to_h
    @authorization = self.authorization
  end

  def publish(hash)
    response = post(hash)
    pp response.body
    JSON.parse(response.body)["response"]
  end

  def info
    uri = USER_INFO
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request request(uri)
    end
  end

  def post(post_params)
    uri = POST_URI
    req = request(POST_URI, post_params)
    Net::HTTP.start(req.uri.host, req.uri.port, use_ssl: true) do |http|
      http.request req
    end
  end

  def request(uri, params={})
    Net::HTTP::Post.new(uri).tap do |req|
      req.form_data = params
      # auth_header = @authorization.merge({oauth_signature: signature(req, params)}).sort.map do |k,v|
      #   %Q(#{k}="#{escape(v)}")
      # end.join(", ") #My OAuth isn't working :-(
      req["Authorization"] = SimpleOAuth::Header.new(req.method, req.uri, params, {
        consumer_key: @oauth["TUMBLR_CONSUMER_KEY"],
        token: @oauth["TUMBLR_OAUTH_TOKEN"],
        consumer_secret: @oauth["TUMBLR_CONSUMER_SECRET"],
        token_secret: @oauth["TUMBLR_OAUTH_TOKEN_SECRET"]
      }).to_s
    end
  end

  def authorization
    {
      oauth_consumer_key: @oauth["TUMBLR_CONSUMER_KEY"],
      oauth_token: @oauth["TUMBLR_OAUTH_TOKEN"],
      oauth_signature_method: 'HMAC-SHA1',
      oauth_timestamp: Time.now.to_i.to_s,
      oauth_nonce: SecureRandom.hex,
      oauth_version: "1.0"
    }
  end

  def signature(req, params={})
    normalized_params = @authorization.merge(params).sort.map{|k,v| "#{k}=#{escape(v)}" }.join("&")
    base = [req.method, req.uri.to_s, normalized_params].map do |item|
      escape(item)
    end.join("&")
    digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, secret, base)
    Base64.strict_encode64(digest)
  end

  def secret
    key = [
      @oauth["TUMBLR_CONSUMER_SECRET"],
      @oauth["TUMBLR_OAUTH_TOKEN_SECRET"]
    ].map {|item| escape(item) }.join("&")
  end

private

  def escape(item)
    URI.encode_www_form_component(item)
  end
end

