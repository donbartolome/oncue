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
end
