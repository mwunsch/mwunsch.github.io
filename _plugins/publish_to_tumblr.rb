require 'jekyll'
require 'tumblr_client'

class PublishToTumblr < Jekyll::Generator
  def generate(site)
    tumblelog = site.categories["tumblelog"]
    # Filter only the unpublished posts
    # tumblelog.reject(&:published?).each do |post|
    tumblelog.each do |post|
      # Publish the post to Tumblr according to the post type
      # case post.data["type"]
      # when "photo"
      # when "quote"
      # when "link"
      # when "chat"
      # when "audio"
      # when "video"
      # else # text
      # end
    end
  end

  def tumblr_client
    Tumblr.configure do |conf|
      # Pull keys out of the ENV
    end
  end
end

