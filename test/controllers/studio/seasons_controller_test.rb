require "test_helper"

class Studio::SeasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @studio_season = studio_seasons(:one)
  end

  test "should get index" do
    get studio_seasons_url
    assert_response :success
  end

  test "should get new" do
    get new_studio_season_url
    assert_response :success
  end

  test "should create studio_season" do
    assert_difference("Studio::Season.count") do
      post studio_seasons_url, params: { studio_season: { end_year: @studio_season.end_year, name: @studio_season.name, start_year: @studio_season.start_year, studio_id: @studio_season.studio_id } }
    end

    assert_redirected_to studio_season_url(Studio::Season.last)
  end

  test "should show studio_season" do
    get studio_season_url(@studio_season)
    assert_response :success
  end

  test "should get edit" do
    get edit_studio_season_url(@studio_season)
    assert_response :success
  end

  test "should update studio_season" do
    patch studio_season_url(@studio_season), params: { studio_season: { end_year: @studio_season.end_year, name: @studio_season.name, start_year: @studio_season.start_year, studio_id: @studio_season.studio_id } }
    assert_redirected_to studio_season_url(@studio_season)
  end

  test "should destroy studio_season" do
    assert_difference("Studio::Season.count", -1) do
      delete studio_season_url(@studio_season)
    end

    assert_redirected_to studio_seasons_url
  end
end
