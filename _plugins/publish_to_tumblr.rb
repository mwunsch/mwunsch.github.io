require 'jekyll'
require 'tumblr_client'
require 'net/http'
require 'uri'
require 'json'
require 'securerandom'
require 'pp'

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
      response = case post.data["type"]
        when "photo", "quote", "link", "chat", "audio", "video"
          {}
        else # text
          tumblr_client.publish({
            title: post.data["title"],
            body: post.to_s,
            date: post.date,
            slug: post.slug,
            format: markdown?(site, post) ? "markdown" : "html",
            # See: https://groups.google.com/forum/#!topic/tumblr-api/2E_rGjl9PE4
            # source_url: "#{site.config['url']}#{post.url}",
            # The tumblr_client gem does not allow this param, but maybe I can just craft the request myself
            state: post.is_a?(Jekyll::Draft) ? "draft" : "queue" # Guard against my own foolishness.
          })
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
    @client = Tumblr::Client.new({
      consumer_key: @oauth["TUMBLR_CONSUMER_KEY"],
      consumer_secret: @oauth["TUMBLR_CONSUMER_SECRET"],
      oauth_token: @oauth["TUMBLR_OAUTH_TOKEN"],
      oauth_token_secret: @oauth["TUMBLR_OAUTH_TOKEN_SECRET"]
    })
    @authorization = self.authorization
  end

  def publish(hash)
    @client.text(HOST, hash)
  end

  def info
    uri = USER_INFO
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request request(uri)
    end
  end

  def post(post_params)
    uri = POST_URI
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request request(uri, post_params)
    end
  end

  def request(uri, params={})
    Net::HTTP::Post.new(uri).tap do |req|
      auth_header = @authorization.merge({oauth_signature: signature(req, params)}).map do |k,v|
        %Q(#{k}="#{escape(v)}")
      end.join(", ")

      req.form_data = params
      req["Authorization"] = "OAuth #{auth_header}"
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
    normalized_params = @authorization.merge(params).sort.map{|k,v| "#{k}=#{v}" }.join("&")
    base = [req.method, req.uri.to_s, normalized_params].map do |item|
      escape(item)
    end.join("&")
    digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, secret, base)
    Base64.urlsafe_encode64(digest)
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

