require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category0 = Category.create(name: "sports")
    @category1 = Category.create(name: "programming")
  end

  test "should show list" do
    get categories_path
    assert_template "categories/index"
    assert_select "a[href=?]", category_path(@category0), text: @category0.name
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
  end
end