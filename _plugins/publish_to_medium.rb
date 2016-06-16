require 'jekyll'

Jekyll::Hooks.register :documents, :pre_render do |post|
  next unless PublishToMedium.publishable?(post)
  begin
    puts "Publishing #{post.id}"
  end
end

class PublishToMedium
  def self.suitable?(post)
    post.data["categories"].include?("tumblelog") && ["text", nil].include?(post.data["type"])
  end

  def self.publishable?(post)
    suitable?(post) && !post.data.key?("tumblr_id")
  end
end
