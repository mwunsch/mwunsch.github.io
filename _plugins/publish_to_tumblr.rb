require 'jekyll'
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
      post_defaults = {
        date: post.date.to_s,
        slug: post.slug,
        format: markdown?(site, post) ? "markdown" : "html",
        tags: post.tags.join(","),
        type: post.data["type"] || "text",
        # See: https://groups.google.com/forum/#!topic/tumblr-api/2E_rGjl9PE4
        source_url: "#{site.config['url']}#{post.url}",
        state: post.draft? ? "draft" : "published"
      }
      response = case post.data["type"]
        when "quote", "chat", "audio", "video"
          {}
        when "photo"
          img_src_params = if post.data['source'] =~ URI::regexp(['http','https'])
                             { source: post.data['source'] }
                           else
                             { data: File.read(File.join(site.source, post.data['source']), encoding: "BINARY") }
                           end
          publish post_defaults.merge({ caption: post.to_s,
                                        link: post.data["link"].to_s
                                      }).merge(img_src_params)
        when "link"
          publish post_defaults.merge({ title: post.data["title"].to_s,
                                        url: post.data["link_url"].to_s,
                                        description: post.to_s })
        else # text
          publish post_defaults.merge({ title: post.data["title"].to_s, body: post.to_s })
        end
      if response.empty? || response["status"] || !response.has_key?("id")
        warn "Encountered an error when attempting to publish '#{post.slug}' to Tumblr. Ignoring.\n\t#{response.to_json}"
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

  def publish(post_hash)
    TumblrConnection.new.publish post_hash
  end
end

class TumblrConnection
  HOST = "mwunsch.tumblr.com"
  POST_URI = URI("https://api.tumblr.com/v2/blog/#{HOST}/post")
  EDIT_URI = URI("https://api.tumblr.com/v2/blog/#{HOST}/post/edit")
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

  def publish(params)
    req = request(POST_URI, params)
    response = Net::HTTP.start(req.uri.host, req.uri.port, use_ssl: true) do |http|
      http.request req
    end
    JSON.parse(response.body)["response"]
  end

  def edit(params)
    req = request(EDIT_URI, params)
    response = Net::HTTP.start(req.uri.host, req.uri.port, use_ssl: true) do |http|
      http.request req
    end
    JSON.parse(response.body)["response"]
  end

  def request(uri, params={})
    Net::HTTP::Post.new(uri).tap do |req|
      req.form_data = params
      sig = { oauth_signature: signature(req, params) }
      auth_header = @authorization.merge(sig).sort.map {|k,v| %Q<#{k}="#{escape(v)}"> }.join(", ")
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
    # http://oauth.net/core/1.0a/#encoding_parameters
    URI.escape(item.to_s, /[^a-z0-9\-\.\_\~]/i)
  end
end
