require "test_helper"

class StudiosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get studios_index_url
    assert_response :success
  end

  test "should get new" do
    get studios_new_url
    assert_response :success
  end

  test "should get create" do
    get studios_create_url
    assert_response :success
  end

  test "should get show" do
    get studios_show_url
    assert_response :success
  end

  test "should get edit" do
    get studios_edit_url
    assert_response :success
  end

  test "should get update" do
    get studios_update_url
    assert_response :success
  end

  test "should get destroy" do
    get studios_destroy_url
    assert_response :success
  end
end
