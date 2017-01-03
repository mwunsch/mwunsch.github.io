require 'jekyll'
require 'net/http'
require 'uri'
require 'json'
require 'securerandom'
require 'pp'


class PublishToMedium < Jekyll::Generator
  def generate(site)
    if MediumClient::available?
      warn("Missing Medium Integration Token in ENV. Will not attempt to publish to Medium.")
      return nil
    end
    published = []
    MediumClient.with_author do |response|
      author = response["id"]
      MediumClient.publishable(author, site).each do |post|
        puts "Publishing #{post.id}"
        post.publish do |id, post|
          post.data['medium_id'] = id
          chunks = File.readlines(post.path).slice_before(/-{3}/).to_a
          chunks.first.push("medium_id: #{id}")
          File.open(post.path, "w")  {|f| f.puts chunks }
          published << post
          puts "Success. Updated #{post.path} to reflect changes."
        end
      end
    end

    abort "Updated #{published.count} post(s)." unless published.empty?
  end
end

class MediumClient
  API_TOKEN = ENV["MEDIUM_TOKEN"]
  USER_URI = URI("https://api.medium.com/v1/me")
  POST_URI = ->(id) { URI("https://api.medium.com/v1/users/#{id}/posts") }

  def self.available?
    API_TOKEN.nil?
  end

  def self.publishable(author_id, site)
    site.categories["thinkpiece"].select(&:published?).reject {|p| p.data.key?('medium_id') }.map do |post|
      new(author_id, post)
    end
  end

  def self.with_author
    response = Net::HTTP.start(USER_URI.host, USER_URI.port, use_ssl: true) do |http|
      http.request Net::HTTP::Get.new(USER_URI).tap {|req| with_default_headers(req) }
    end
    response.value
    yield JSON.parse(response.body)["data"]
  end

  attr_reader :post, :site, :uri

  def initialize(author, doc)
    @post = doc
    @site = @post.site
    @uri = POST_URI.call(author)
  end

  def id
    @post.id
  end

  def markdown?
    extensions = site.config["markdown_ext"].split(",").map {|e| ".#{e.downcase}"}
    extensions.include? post.extname
  end

  def to_h
    {
      title: post.data['title'].to_s,
      contentFormat: markdown? ? 'markdown' : 'html',
      content: post.to_s,
      tags: post.data['tags'],
      canonicalUrl: "#{site.config['url']}#{post.url}",
      publishStatus: "draft"
    }
  end

  def request
    Net::HTTP::Post.new(uri).tap do |req|
      self.class.with_default_headers(req)
      req.body = to_h.to_json
    end
  end

  def publish(net = true)
    if !net
      warn "Dry run: no network requests are being made"
      yield SecureRandom.random_number(1000), post
      return false
    end
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request request
    end
    res.value
    response = JSON.parse(res.body)["data"]
    yield response['id'], post
  end

private

  def self.with_default_headers(req)
    req["Authorization"] = "Bearer #{API_TOKEN}"
    req["Accept"] = "application/json"
    req["Accept-Charset"] = "utf-8"
    req.content_type = "application/json"
    req
  end

end
