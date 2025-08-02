require "test_helper"

class StudioMembershipTest < ActiveSupport::TestCase
  def setup
    @studio_membership = build(:studio_membership)
  end

  test "is valid with all required attributes" do
    assert @studio_membership.valid?
  end

  test "is invalid without person" do
    @studio_membership.person = nil

    assert_not @studio_membership.valid?
    assert_includes @studio_membership.errors[:person], "must exist"
  end

  test "is invalid without studio" do
    @studio_membership.studio = nil

    assert_not @studio_membership.valid?
    assert_includes @studio_membership.errors[:studio], "must exist"
  end

  test "is invalid without role type" do
    @studio_membership.role = nil

    assert_not @studio_membership.valid?
    assert_includes @studio_membership.errors[:role], "can't be blank"
  end

  test "is invalid with duplicate role for person in same studio" do
    @studio_membership.save!

    duplicate = build(:studio_membership, person: @studio_membership.person, studio: @studio_membership.studio, role: @studio_membership.role)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person], "has already been taken"
  end

  test "is valid with unique roles for person in same studio" do
    @studio_membership.save!

    unique_role = build(:studio_membership, person: @studio_membership.person, studio: @studio_membership.studio, role: :admin)

    assert unique_role.valid?
  end

  test "is valid with same role for person in different studios" do
    @studio_membership.save!

    different_studio_role = build(:studio_membership, person: @studio_membership.person, studio: create(:studio), role: @studio_membership.role)

    assert different_studio_role.valid?
  end
end
