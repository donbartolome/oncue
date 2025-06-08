require "test_helper"

class StudiosControllerTest < ActionDispatch::IntegrationTest
  setup do
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
    get new_studio_url
    assert_response :success
  end

  test "should create studio" do
    assert_difference("Studio.count") do
      post studios_url, params: { studio: {
        name: "Another Studio",
        address_line1: "456 Side St",
        address_line2: "",
        city: "Otherville",
        state: "OS",
        zip_code: "67890"
      } }
    end

    assert_redirected_to studio_url(Studio.last)
  end

  test "should show studio" do
    get studio_url(@studio)
    assert_response :success
  end

  test "should get edit" do
    get edit_studio_url(@studio)
    assert_response :success
  end

  test "should update studio" do
    patch studio_url(@studio), params: { studio: { name: "Updated Studio" } }
    assert_redirected_to studio_url(@studio)

    @studio.reload
    assert_equal "Updated Studio", @studio.name
  end

  test "should destroy studio" do
    assert_difference("Studio.count", -1) do
      delete studio_url(@studio)
    end

    assert_redirected_to studios_url
  end
end
