require 'jekyll'
require 'tumblr_client'
require 'pp'

class PublishToTumblr < Jekyll::Generator
  def generate(site)
    if env_vars.none?
      warn("Missing Tumblr OAuth Tokens in ENV. Will not attempt to publish to Tumblr.")
      return nil
    end
    blog_host = "mwunsch.tumblr.com"
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
          tumblr_client.text(blog_host, {
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

  def env_vars
    %w( TUMBLR_CONSUMER_KEY
        TUMBLR_CONSUMER_SECRET
        TUMBLR_OAUTH_TOKEN
        TUMBLR_OAUTH_TOKEN_SECRET ).map {|v| ::ENV.assoc(v) }
  end

  def markdown?(site, post)
    extensions = site.config["markdown_ext"].split(",").map {|e| ".#{e.downcase}"}
    extensions.include? post.ext
  end

  def tumblr_client
    env = env_vars.to_h
    @tumblr_client ||= Tumblr::Client.new({
      consumer_key: env["TUMBLR_CONSUMER_KEY"],
      consumer_secret: env["TUMBLR_CONSUMER_SECRET"],
      oauth_token: env["TUMBLR_OAUTH_TOKEN"],
      oauth_token_secret: env["TUMBLR_OAUTH_TOKEN_SECRET"]
    })
  end
end

