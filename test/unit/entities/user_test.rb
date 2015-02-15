require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def valid_attrs(**overrides)
    { first_name: "Chris",
      last_name:  "Ertel",
      email:      "chris@placeholderurl.com",
      admin:      true,
      active:     true,
    }.merge(overrides)
  end


  test "can be initialized with expected attributes" do
    u = User.new(valid_attrs)
    assert(u.valid?)
  end


  test "provides a default value for admin" do
    u = User.new(valid_attrs.except(:admin))
    assert(u.valid?)
  end


  test "provides a default value for active" do
    u = User.new(valid_attrs.except(:active))
    assert(u.valid?)
  end


  test "email must be a valid email" do
    u = User.new(valid_attrs(email: "not a valid email"))
    refute(u.valid?)
    u = User.new(valid_attrs(email: "not_valid_no_at_sign"))
    refute(u.valid?)
    u = User.new(valid_attrs(email: "@placeholderurl.com"))
    refute(u.valid?)
    u = User.new(valid_attrs(email: "chris@"))
    refute(u.valid?)
  end


  test "requires a name" do
    u = User.new(valid_attrs(first_name: ""))
    refute(u.valid?)
    u = User.new(valid_attrs.except(:first_name))
    refute(u.valid?)
    u = User.new(valid_attrs(last_name: ""))
    refute(u.valid?)
    u = User.new(valid_attrs.except(:last_name))
    refute(u.valid?)
  end

end
