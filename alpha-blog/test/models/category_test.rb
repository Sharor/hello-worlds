require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "Name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "Name is unique" do
    @category.save
    duplicate_category = Category.new(name: "sports")
    assert_not duplicate_category.valid?
  end

  test "name too long" do
    @category.name = "a"*26
    assert_not @category.valid?
  end

  test "name too short" do
    @category.name = "a"
    assert_not @category.valid?
  end
end