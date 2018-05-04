require 'test_helper'

class ArticleCreatedTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Admini", email: "admin@admin.com", password: "passboy", admin: false)
  end

  test "new article" do
    sign_in_as(@user, "passboy")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post article_path, params: { category: {title: "I am passionate about something",
                                              description: "So I talk about it a loooooot"}}
      follow_redirect!
    end
    assert_template 'articles/index'
    assert_match "I am passionate about something", response.body
  end
end