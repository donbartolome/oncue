require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, password: "password")
  end

  # new
  test "renders new password form" do
    get new_password_url

    assert_response :success
  end

  # create
  test "sends reset instructions when email exists" do
    assert_enqueued_emails 1 do
      post passwords_url, params: { email_address: @user.email_address }
    end

    assert_redirected_to new_session_path
    assert_match(/Password reset instructions sent/, flash[:notice])
  end

  test "does not fail and redirects when email does not exist" do
    assert_enqueued_emails 0 do
      post passwords_url, params: { email_address: "notfound@example.com" }
    end

    assert_redirected_to new_session_path
    assert_match(/Password reset instructions sent/, flash[:notice])
  end

  # edit
  test "renders edit form with valid token" do
    token = @user.password_reset_token

    get edit_password_url(token: token)

    assert_response :success
  end

  test "redirects to new with invalid token" do
    get edit_password_url(token: "invalidtoken")

    assert_redirected_to new_password_path
    assert_match(/invalid or has expired/i, flash[:alert])
  end

  # update
  test "resets password with valid token and matching confirmation" do
    token = @user.password_reset_token

    patch password_url(token: token), params: { password: "newpass", password_confirmation: "newpass" }

    assert_redirected_to new_session_path
    assert_match(/Password has been reset/, flash[:notice])

    @user.reload

    assert @user.authenticate("newpass")
  end

  test "does not reset password if confirmation does not match" do
    token = @user.password_reset_token

    patch password_url(token: token), params: { password: "newpass", password_confirmation: "wrong" }

    assert_redirected_to edit_password_path(token)
    assert_match(/Passwords did not match/, flash[:alert])

    @user.reload

    assert @user.authenticate("password")
  end

  test "redirects to new when updating with invalid token" do
    patch password_url(token: "invalidtoken"), params: { password: "newpass", password_confirmation: "newpass" }

    assert_redirected_to new_password_path
    assert_match(/invalid or has expired/i, flash[:alert])

    @user.reload

    assert @user.authenticate("password")
  end
end
