require 'test_helper'

class LeadTest < ActiveSupport::TestCase

  def valid_attrs(**overrides)
    { first_name: "Chris",
      last_name:  "Ertel",
      email:      "chris@placeholderurl.com",
      phone:      "(123)-456-7890",
      position:   "Lead Developer"
    }.merge(overrides)
  end


  test "can be initialized with expected attributes" do
    l = Lead.new(valid_attrs)
    assert(l.valid?)
  end


  test "phone must be a valid phone number" do
    l = Lead.new(valid_attrs(phone: "1234567890"))
    assert(l.valid?)
    l = Lead.new(valid_attrs(phone: "123-4567"))
    refute(l.valid?)
    l = Lead.new(valid_attrs(phone: "(---)-123-4567"))
    refute(l.valid?)
  end


  test "email must be a valid email" do
    l = Lead.new(valid_attrs(email: "not a valid email"))
    refute(l.valid?)
    l = Lead.new(valid_attrs(email: "not_valid_no_at_sign"))
    refute(l.valid?)
    l = Lead.new(valid_attrs(email: "@placeholderurl.com"))
    refute(l.valid?)
    l = Lead.new(valid_attrs(email: "chris@"))
    refute(l.valid?)
  end


  test "requires a name" do
    l = Lead.new(valid_attrs(first_name: ""))
    refute(l.valid?)
    l = Lead.new(valid_attrs.except(:first_name))
    refute(l.valid?)
    l = Lead.new(valid_attrs(last_name: ""))
    refute(l.valid?)
    l = Lead.new(valid_attrs.except(:last_name))
    refute(l.valid?)
  end

end
