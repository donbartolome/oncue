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

    assert_redirected_to new_studio_season_path
    assert_match(/can't be blank/, flash[:alert])

    @season.reload

    assert_not_equal "", @season.name
  end

  test "does not create season when start_year is greater than end_year" do
    sign_in_as(@user)

    assert_no_difference("Season.count") do
      post studio_seasons_url(@studio), params: {
        season: {
          name: "Invalid Season",
          start_year: 3000,
          end_year: 1000,
          studio_id: @studio.id
        }
      }
    end

    assert_redirected_to new_studio_season_path
    assert_match(/greater than end year/, flash[:alert])

    @season.reload

    assert_not_equal 3000, @season.start_year
    assert_not_equal 1000, @season.end_year
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

    assert_redirected_to edit_season_path
    assert_match(/can't be blank/, flash[:alert])

    @season.reload

    assert_not_equal "", @season.name
  end

  test "does not update season when start_year is greater than end_year" do
    sign_in_as(@user)

    patch season_url(@season), params: {
      season: {
        start_year: 3000,
        end_year: 1000
      }
    }

    assert_redirected_to edit_season_path
    assert_match(/greater than end year/, flash[:alert])

    @season.reload

    assert_not_equal 3000, @season.start_year
    assert_not_equal 1000, @season.end_year
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
    assert_redirected_to studio_seasons_url(@season.studio)
  end

  test "returns 404 for destroy with invalid id" do
    sign_in_as(@user)

    delete season_url(-1)
    assert_response :not_found
  end

  test "renders select_dancer" do
    sign_in_as(@user)

    dancers = create_list(:person, 3)
    dancers.each do |dancer|
      @season.studio.add_dancer(dancer)
      @season.add_dancer(dancer)
    end

    @season.reload

    get select_dancer_season_url(@season)
    assert_response :success
    assert_equal dancers, @season.get_dancers
  end

  test "returns 404 for select_dancer with invalid id" do
    sign_in_as(@user)

    assert_no_difference("@studio.people.count") do
      get select_dancer_season_url(-1)
    end

    assert_response :not_found
  end

  test "adds dancer to season" do
    sign_in_as(@user)

    dancer = create(:person)
    @season.studio.add_dancer(dancer)

    assert_difference("@season.get_dancers.count") do
      post add_dancer_season_url(@season), params: { person_id: dancer.id }
    end

    assert_redirected_to season_path(@season)
    assert_match(/successfully added/, flash[:notice])
  end

  test "does not add dancer to season if dancer is not a member of the studio" do
    sign_in_as(@user)

    dancer = create(:person)

    assert_no_difference("@studio.people.count") do
      post add_dancer_season_url(@season), params: { person_id: dancer.id }
    end

    assert_redirected_to select_dancer_season_path(@season)
    assert_match(/must be a member of the studio/, flash[:alert])
  end

  test "returns 404 for add_dancer with invalid season id" do
    sign_in_as(@user)

    dancer = create(:person)

    assert_no_difference("@studio.people.count") do
      post add_dancer_season_url(-1), params: { person_id: dancer.id }
    end

    assert_response :not_found
  end

  test "returns 404 for add_dancer with invalid person id" do
    sign_in_as(@user)

    assert_no_difference("@studio.people.count") do
      post add_dancer_season_url(@season), params: { person_id: -1 }
    end

    assert_response :not_found
  end
end
