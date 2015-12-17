require 'test_helper'

class ArticleCreationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def create_user
    visit new_author_path

    fill_in "author[username]", with: "admin"
    fill_in "author[email]", with: "admin@example.com"
    fill_in "author[password]", with: "password"
    fill_in "author[password_confirmation]", with: "password"

    click_button "Create Author"

    visit login_path

    fill_in "author[email]", with: "admin@example.com"
    fill_in "author[password]", with: "password"
  end

  test "user can create an article" do
    create_user

    visit new_article_path

    fill_in "article[title]", with: "My first blog post"
    fill_in "article[body]", with: "Kittens are the cutest"

    click_button "Create Article"

    assert page.has_content?("My first blog post")
    assert page.has_content?("Kittens are the cutest")
    assert_equal current_path, article_path(Article.last)
  end
end
