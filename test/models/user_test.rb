require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test "is valid with all required attributes" do
    assert @user.valid?
  end

  test "is invalid without an email address" do
    @user.email_address = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "can't be blank"
  end

  test "is invalid without a password" do
    @user.password_digest = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password_digest], "can't be blank"
  end

  test "should authenticate with valid password" do
    assert @user.authenticate("password")
  end
end
