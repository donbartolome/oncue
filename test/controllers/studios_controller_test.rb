require "test_helper"

class StudiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    @studio = Studio.create!(
      name: "Test Studio",
      address_line1: "123 Main St",
      address_line2: "",
      city: "Testville",
      state: "TS",
      zip_code: "12345"
    )
  end

  test "should get index" do
    get studios_url
    assert_response :success
  end

  test "should get new" do
    # sign_in_as(@user)

    get new_studio_url, headers: auth_headers(@user)
    assert_response :success
  end

  # post articles_url, params: { article: { body: "Rails is awesome!", title: "Hello Rails" } }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }


  test "should create studio" do
    # sign_in_as(@user)

    assert_difference("Studio.count") do
      post studios_url, params: { studio: {
        name: "Another Studio",
        address_line1: "456 Side St",
        address_line2: "",
        city: "Otherville",
        state: "OS",
        zip_code: "67890"
      } }, headers: auth_headers(@user)
    end

    assert_redirected_to studio_url(Studio.last)
  end

  test "should show studio" do
    get studio_url(@studio)
    assert_response :success
  end

  test "should get edit" do
    # sign_in_as(@user)

    get edit_studio_url(@studio), headers: auth_headers(@user)
    assert_response :success
  end

  test "should update studio" do
    # sign_in_as(@user)

    patch studio_url(@studio), params: { studio: { name: "Updated Studio" } }, headers: auth_headers(@user)
    assert_redirected_to studio_url(@studio)

    @studio.reload
    assert_equal "Updated Studio", @studio.name
  end

  test "should destroy studio" do
    # sign_in_as(@user)

    assert_difference("Studio.count", -1) do
      delete studio_url(@studio), headers: auth_headers(@user)
    end

    assert_redirected_to studios_url
  end

  private

  # Helper method for signing in a user in tests
  # def sign_in_as(user)
  #   post login_url, params: { email_address: user.email_address, password: "password" }
  # end

  def auth_headers(user)
    {
      "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(
        user.email_address, "password"
      )
    }
    end
end
