require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, password: "password")
  end

  # new
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  # create
  test "should create session with valid credentials" do
    sign_in_as(@user)

    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should not create session with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "wrongpassword" }
    assert_redirected_to new_session_url
  end

  # destroy
  test "should destroy session" do
    sign_in_as(@user)

    delete session_url
    assert_response :redirect
    assert_redirected_to new_session_url
  end
end
