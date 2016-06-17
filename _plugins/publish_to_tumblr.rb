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
    TumblrConnection.publishable(site).each do |post|
      puts "Publishing #{post.id}"
      TumblrConnection.new(post).publish(false) do |id, post|
        post.data['tumblr_id'] = id
        chunks = File.readlines(post.path).slice_before(/-{3}/).to_a
        chunks.first.push("tumblr_id: #{id}")
        File.open(path, "w") {|f| f.puts chunks }
        published << post
        puts "Success. Updated #{post.path} to reflect changes."
      end
    end

    abort "Updated #{published.count} post(s)." unless published.empty?
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

  def self.publishable(site)
    site.categories['tumblelog'].select(&:published?).reject {|p| p.data.key?('tumblr_id') }
  end

  attr_reader :post, :site

  def initialize(doc)
    @oauth = OAUTH_VARS.compact.to_h
    @authorization = self.authorization
    @post = doc
    @site = @post.site
    @type = @post.data['type'] || 'text'
  end

  def defaults
    {
      date: post.date.to_s,
      slug: post.data['slug'],
      format: markdown? ? 'markdown' : 'html',
      tags: post.data['tags'].join(','),
      type: @type,
      # See: https://groups.google.com/forum/#!topic/tumblr-api/2E_rGjl9PE4
      source_url: "#{site.config['url']}#{post.url}",
      state: post.draft? ? 'draft' : 'published'
    }
  end

  def to_h
    case @type
    when 'quote', 'chat', 'audio', 'video'
      {}
    when 'photo'
      img_src_params = if post.data['source'] =~ URI::regexp(['http','https'])
                         { source: post.data['source'] }
                       else
                         { data: File.read(File.join(site.source, post.data['source']), encoding: "BINARY") }
                       end
      defaults.merge({ caption: post.to_s, link: post.data['link'].to_s }).merge(img_src_params)
    when 'link'
      defaults.merge({ title: post.data['title'].to_s,
                       url: post.data['link_url'].to_s,
                       description: post.to_s })
    else # text
      defaults.merge({ title: post.data['title'].to_s, body: post.to_s })
    end
  end

  def markdown?
    extensions = site.config["markdown_ext"].split(",").map {|e| ".#{e.downcase}"}
    extensions.include? post.extname
  end

  def publish(net = true)
    if !net
      warn "Dry run: no network requests are being made"
      yield SecureRandom.random_number(1000), post
      return false
    end
    if !self.class.available?
      warn "You're trying to publish to Tumblr but your credentials are missing!"
      return nil
    end
    req = request(POST_URI)
    res = Net::HTTP.start(req.uri.host, req.uri.port, use_ssl: true) do |http|
      http.request req
    end
    response = JSON.parse(res.body)["response"]
    if response.empty? || response['status'] || !response.has_key?('id')
    else
      yield response['id'], post
    end
  end

  def request(uri)
    Net::HTTP::Post.new(uri).tap do |req|
      req.form_data = to_h
      sig = { oauth_signature: signature(req) }
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

  def signature(req)
    normalized_params = @authorization.merge(to_h).sort.map{|k,v| "#{k}=#{escape(v)}" }.join("&")
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
