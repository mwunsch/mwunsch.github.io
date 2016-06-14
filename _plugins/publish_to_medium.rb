require 'jekyll'

Jekyll::Hooks.register :documents, :pre_render do |post|
  if PublishToMedium.suitable?(post)
    p post.data["slug"]
  end
end

class PublishToMedium
  def self.suitable?(post)
    post.data["categories"].include?("tumblelog") && ["text", nil].include?(post.data["type"])
  end
end
