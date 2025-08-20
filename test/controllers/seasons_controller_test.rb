require "test_helper"

class SeasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @studio = create(:studio)
    @season = create(:season, studio: @studio)
  end

  # index
  test "renders index" do
    sign_in_as(@user)

    get studio_seasons_url(@studio)
    assert_response :success
  end

  # new
  test "renders new season form" do
    sign_in_as(@user)

    get new_studio_season_url(@studio)
    assert_response :success
  end

  # create
  test "creates season" do
    sign_in_as(@user)

    assert_difference("Season.count") do
      post studio_seasons_url(@studio), params: { season: attributes_for(:season) }
    end
    assert_redirected_to season_url(Season.last)
  end

  test "does not create season with invalid params" do
    sign_in_as(@user)

    assert_no_difference("Season.count") do
      post studio_seasons_url(@studio), params: { season: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  # show
  test "renders season" do
    sign_in_as(@user)

    get season_url(@season)
    assert_response :success
  end

  test "returns 404 for show with invalid id" do
    sign_in_as(@user)

    get season_url(-1)
    assert_response :not_found
  end

  # edit
  test "renders edit season form" do
    sign_in_as(@user)

    get edit_season_url(@season)
    assert_response :success
  end

  test "returns 404 for edit with invalid id" do
    sign_in_as(@user)

    get edit_season_url(-1)
    assert_response :not_found
  end

  # update
  test "updates season" do
    sign_in_as(@user)

    patch season_url(@season), params: { season: { name: "Updated Season" } }
    assert_redirected_to season_url(@season)
    @season.reload
    assert_equal "Updated Season", @season.name
  end

  test "does not update season with invalid params" do
    sign_in_as(@user)

    patch season_url(@season), params: { season: { name: "" } }
    assert_response :unprocessable_entity
    @season.reload
    assert_not_equal "", @season.name
  end

  test "returns 404 for update with invalid id" do
    sign_in_as(@user)

    patch season_url(-1), params: { season: { name: "Doesn't Matter" } }
    assert_response :not_found
  end

  # destroy
  test "destroys season" do
    sign_in_as(@user)

    assert_difference("Season.count", -1) do
      delete season_url(@season)
    end
    assert_redirected_to studio_seasons_url
  end

  test "returns 404 for destroy with invalid id" do
    sign_in_as(@user)

    delete season_url(-1)
    assert_response :not_found
  end
end
