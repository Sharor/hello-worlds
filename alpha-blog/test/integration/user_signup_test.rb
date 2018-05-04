require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "new user" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post user_path, params: { user: {username: "John",
                                              email: "j@j.com", password: "password"}}
      follow_redirect!
    end
    assert_template ' users/show'
  end
end