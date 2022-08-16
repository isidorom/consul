require "rails_helper"

describe Shared::CommentsInfoComponent do
  it "renders comments info with url and with defalut icon class" do
    render_inline Shared::CommentsInfoComponent.new(0, url: "http://www.url.com")

    expect(page.find(".comments-count")).to have_content "No comments"
    expect(page.find(".comments-count")).to have_link "No comments", href: "http://www.url.com"
  end

  it "renders comments info without url and with defalut icon class" do
    render_inline Shared::CommentsInfoComponent.new(1)

    expect(page.find(".comments-count")).to have_content "1 comment"
    expect(page.find(".comments-count")).not_to have_link "1 comment"
  end

  it "renders comments info with url and with another icon class" do
    render_inline Shared::CommentsInfoComponent.new(2, url: "http://www.url.com", icon_class: "new-class")

    expect(page.find(".new-class")).to have_content "2 comments"
    expect(page.find(".new-class")).to have_link "2 comments", href: "http://www.url.com"
  end
end
