require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "Admini", email: "admin@admin.com", password: "passboy", admin: true)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get categories new" do
    sign_in_as(@user, "passboy")
    get new_category_path
    assert_response :success
  end

  test "should get categories show" do
    get category_path(@category)
    assert_response :success
  end

  test "admin creates categories, users do not" do
    assert_no_difference 'Category.count' do
      post categories_path, params:{category:{name:"sports"}}
    end
    assert_redirected_to categories_path
  end


end