class Shared::CommentsInfoComponent < ApplicationComponent
  attr_reader :comments_count, :url, :icon_class

  def initialize(comments_count, url: nil, icon_class: "comments-count")
    @comments_count = comments_count
    @url = url
    @icon_class = icon_class
  end

  def comments_info
    tag.span class: icon_class, "area-hidden": true do
      link_to_if url.present?, text, url
    end
  end

  def text
    t("shared.comments", count: comments_count)
  end
end
