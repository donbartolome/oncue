require "test_helper"

class SeasonMembershipTest < ActiveSupport::TestCase
  def setup
    @season_membership = build(:season_membership)
  end

  test "is valid with all required attributes" do
    assert @season_membership.valid?
  end

  test "is invalid without person" do
    @season_membership.person = nil

    assert_not @season_membership.valid?
    assert_includes @season_membership.errors[:person], "must exist"
  end

  test "is invalid without season" do
    @season_membership.season = nil

    assert_not @season_membership.valid?
    assert_includes @season_membership.errors[:season], "must exist"
  end

  test "is invalid without role type" do
    @season_membership.role = nil

    assert_not @season_membership.valid?
    assert_includes @season_membership.errors[:role], "can't be blank"
  end

  test "is invalid with duplicate role for person in same season" do
    @season_membership.save!

    duplicate = build(:season_membership, person: @season_membership.person, season: @season_membership.season, role: @season_membership.role)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person], "has already been taken"
  end

  test "is valid with unique roles for person in same season" do
    @season_membership.save!

    unique_role = build(:season_membership, person: @season_membership.person, season: @season_membership.season, role: :choreographer)

    assert unique_role.valid?
  end

  test "is valid with same role for person in different seasons" do
    @season_membership.save!

    different_season_role = build(:season_membership, person: @season_membership.person, season: create(:season), role: @season_membership.role)

    assert different_season_role.valid?
  end
end
