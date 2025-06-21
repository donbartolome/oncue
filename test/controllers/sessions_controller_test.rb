require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should log in with valid credentials" do
    user = create(:user, password: "password")
    post session_path, params: { email_address: user.email_address, password: "password" }
    assert_redirected_to root_path
    assert_equal user.id, session[:user_id]
  end

  test "should not log in with invalid credentials" do
    post session_path, params: { email_address: "wrong@example.com", password: "wrong" }
    # assert_response :unprocessable_entity
    assert_redirected_to new_session_path
  end
end
