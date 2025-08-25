require "test_helper"

class SeasonTest < ActiveSupport::TestCase
  def setup
    @season = build(:season)
  end

  test "is valid with all required attributes" do
    assert @season.valid?
  end

  test "is invalid without name" do
    @season.name = nil
    assert_not @season.valid?
    assert_includes @season.errors[:name], "can't be blank"
  end

  test "is invalid without start_year" do
    @season.start_year = nil
    assert_not @season.valid?
    assert_includes @season.errors[:start_year], "can't be blank"
  end

  test "is invalid without end_year" do
    @season.end_year = nil
    assert_not @season.valid?
    assert_includes @season.errors[:end_year], "can't be blank"
  end

  test "is valid when start_year equals end_year" do
    @season.start_year = 2024
    @season.end_year = 2024
    assert @season.valid?
  end

  test "is invalid when start_year is greater than end_year" do
    @season.start_year = 2025
    @season.end_year = 2024
    assert_not @season.valid?
    assert_includes @season.errors[:start_year], "cannot be greater than end year"
  end

  test "is valid when start_year is less than end_year" do
    @season.start_year = 2023
    @season.end_year = 2024
    assert @season.valid?
  end

  test "year returns single year string when start_year equals end_year" do
    @season.start_year = 2024
    @season.end_year = 2024
    assert_equal "2024", @season.year
  end

  test "year returns range string when start_year does not equal end_year" do
    @season.start_year = 2023
    @season.end_year = 2024
    assert_equal "2023 - 2024", @season.year
  end

  test "add_dancer adds dancer role for person" do
    @season.save!

    person = create(:person)
    @season.studio.add_dancer(person)

    assert_difference -> { person.season_memberships.where(season: @season, role: :dancer).count }, 1 do
      result = @season.add_dancer(person)

      assert result.persisted?
      assert_equal :dancer, result.role.to_sym
      assert_equal @season, result.season
    end
  end

  test "add_dancer does not add duplicate dancer role" do
    @season.save!

    person = create(:person)
    @season.studio.add_dancer(person)
    @season.add_dancer(person)

    assert_no_difference -> { person.season_memberships.where(season: @season, role: :dancer).count } do
      result = @season.add_dancer(person)

      assert_not result
      assert_includes @season.errors[:base], "Person is already a dancer in this season."
    end
  end

  test "add_dancer does not add dancer role for person not in studio" do
    @season.save!

    person = create(:person)

    assert_no_difference -> { person.season_memberships.where(season: @season, role: :dancer).count } do
      result = @season.add_dancer(person)

      assert_not result
      assert_includes @season.errors[:base], "Person must be a member of the studio to be added as a dancer."
    end
  end

  test "add_director adds director role for person" do
    @season.save!

    person = create(:person)
    @season.studio.add_owner(person)

    assert_difference -> { person.season_memberships.where(season: @season, role: :director).count }, 1 do
      result = @season.add_director(person)

      assert result.persisted?
      assert_equal :director, result.role.to_sym
      assert_equal @season, result.season
    end
  end

  test "add_director does not add duplicate director role" do
    @season.save!

    person = create(:person)
    @season.studio.add_director(person)
    @season.add_director(person)

    assert_no_difference -> { person.season_memberships.where(season: @season, role: :director).count } do
      result = @season.add_director(person)

      assert_not result
      assert_includes @season.errors[:base], "Person is already a director in this season."
    end
  end

  test "add_director does not add director role for person not in studio" do
    @season.save!

    person = create(:person)

    assert_no_difference -> { person.season_memberships.where(season: @season, role: :director).count } do
      result = @season.add_director(person)

      assert_not result
      assert_includes @season.errors[:base], "Person must be a member of the studio to be added as a director."
    end
  end

  test "get_dancers returns only dancers for the season" do
    @season.save!

    dancer1 = create(:person)
    dancer2 = create(:person)
    director = create(:person)
    @season.studio.add_dancer(dancer1)
    @season.studio.add_dancer(dancer2)
    @season.studio.add_director(director)
    @season.add_dancer(dancer1)
    @season.add_dancer(dancer2)
    @season.add_director(director)

    dancers = @season.get_dancers
    assert_includes dancers, dancer1
    assert_includes dancers, dancer2
    assert_not_includes dancers, director
    assert_equal 2, dancers.count
  end

  test "get_eligible_dancers returns studio dancers not already in season" do
    @season.save!

    eligible = create(:person)
    ineligible = create(:person)
    @season.studio.add_dancer(eligible)
    @season.studio.add_dancer(ineligible)
    @season.add_dancer(ineligible)

    eligible_dancers = @season.get_eligible_dancers
    assert_includes eligible_dancers, eligible
    assert_not_includes eligible_dancers, ineligible
    assert_equal 1, eligible_dancers.count
  end
end
