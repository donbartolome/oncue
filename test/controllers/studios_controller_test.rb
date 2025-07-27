require "test_helper"

class StudiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @studio = create(:studio)
  end

  # index
  test "should get index" do
    get studios_url

    assert_response :success
  end

  # new
  test "should get new" do
    sign_in_as(@user)

    get new_studio_url

    assert_response :success
  end

  test "should redirect new when not signed in" do
    get new_studio_url

    assert_response :redirect
  end

  # create
  test "should create studio" do
    sign_in_as(@user)

    assert_difference("Studio.count") do
      post studios_url, params: { studio: attributes_for(:studio) }
    end

    assert_redirected_to studio_url(Studio.last)
  end

  test "should not create studio with invalid params" do
    sign_in_as(@user)

    assert_no_difference("Studio.count") do
      post studios_url, params: { studio: { name: "", address_line1: "", city: "", state: "", zip_code: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create studio when not signed in" do
    assert_no_difference("Studio.count") do
      post studios_url, params: { studio: attributes_for(:studio) }
    end

    assert_response :redirect
  end

  # show
  test "should show studio" do
    get studio_url(@studio)

    assert_response :success
  end

  test "should return 404 for show with invalid id" do
    get studio_url(-1)

    assert_response :not_found
  end

  # edit
  test "should get edit" do
    sign_in_as(@user)

    get edit_studio_url(@studio)

    assert_response :success
  end

  test "should redirect edit when not signed in" do
    get edit_studio_url(@studio)

    assert_response :redirect
  end

  test "should return 404 for edit with invalid id" do
    sign_in_as(@user)

    get edit_studio_url(-1)

    assert_response :not_found
  end

  # update
  test "should update studio" do
    sign_in_as(@user)

    patch studio_url(@studio), params: { studio: { name: "Updated Studio" } }

    assert_redirected_to studio_url(@studio)

    @studio.reload

    assert_equal "Updated Studio", @studio.name
  end

  test "should not update studio with invalid params" do
    sign_in_as(@user)

    patch studio_url(@studio), params: { studio: { name: "" } }

    assert_response :unprocessable_entity

    @studio.reload

    assert_not_equal "", @studio.name
  end

  test "should not update studio when not signed in" do
    patch studio_url(@studio), params: { studio: { name: "No Auth Update" } }

    assert_response :redirect

    @studio.reload

    assert_not_equal "No Auth Update", @studio.name
  end

  test "should return 404 for update with invalid id" do
    sign_in_as(@user)

    patch studio_url(-1), params: { studio: { name: "Doesn't Matter" } }

    assert_response :not_found
  end

  # destroy
  test "should destroy studio" do
    sign_in_as(@user)

    assert_difference("Studio.count", -1) do
      delete studio_url(@studio)
    end

    assert_redirected_to studios_url
  end

  test "should not destroy studio when not signed in" do
    assert_no_difference("Studio.count") do
      delete studio_url(@studio)
    end

    assert_response :redirect
  end

  test "should return 404 for destroy with invalid id" do
    sign_in_as(@user)

    delete studio_url(-1)

    assert_response :not_found
  end

  # roster
  test "should get roster" do
    sign_in_as(@user)

    dancer = create(:person)
    @studio.add_dancer(dancer)

    get roster_studio_url(@studio)

    assert_response :success
    assert_select "body", /#{dancer.first_name}/
  end

  test "should redirect roster when not signed in" do
    get roster_studio_url(@studio)

    assert_response :redirect
  end

  test "should return 404 for roster with invalid id" do
    sign_in_as(@user)

    get roster_studio_url(-1)

    assert_response :not_found
  end

  # new_dancer
  test "should get new_dancer" do
    sign_in_as(@user)

    get new_dancer_studio_url(@studio)

    assert_response :success
  end

  test "should redirect new_dancer when not signed in" do
    get new_dancer_studio_url(@studio)

    assert_response :redirect
  end

  test "should return 404 for new_dancer with invalid id" do
    sign_in_as(@user)

    get new_dancer_studio_url(-1)

    assert_response :not_found
  end

  # add_dancer
  test "should add dancer and redirect to roster" do
    sign_in_as(@user)

    dancer_attrs = attributes_for(:person)

    assert_difference("@studio.people.count") do
      post add_dancer_studio_url(@studio), params: { person: dancer_attrs }
    end

    assert_redirected_to roster_studio_url(@studio)
  end

  test "should redirect add_dancer when not signed in" do
    dancer_attrs = attributes_for(:person)

    assert_no_difference("@studio.people.count") do
      post add_dancer_studio_url(@studio), params: { person: dancer_attrs }
    end

    assert_response :redirect
  end

  test "should not add dancer with invalid params" do
    sign_in_as(@user)

    assert_no_difference("@studio.people.count") do
      post add_dancer_studio_url(@studio), params: { person: { first_name: "", last_name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not add duplicate dancer" do
    sign_in_as(@user)

    dancer = create(:person)
    @studio.add_dancer(dancer)

    assert_no_difference("@studio.people.count") do
      post add_dancer_studio_url(@studio), params: { person: { first_name: dancer.first_name, last_name: dancer.last_name } }
    end

    assert_response :unprocessable_entity
  end

  test "should return 404 for add_dancer with invalid id" do
    sign_in_as(@user)

    post add_dancer_studio_url(-1), params: { person: attributes_for(:person) }

    assert_response :not_found
  end
end
