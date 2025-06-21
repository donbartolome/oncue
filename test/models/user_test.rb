require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: "password")
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "should authenticate with valid password" do
    user = create(:user, password: "password")
    assert user.authenticate("password")
  end
end
