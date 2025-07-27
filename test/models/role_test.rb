require "test_helper"

class RoleTest < ActiveSupport::TestCase
  def setup
    @role = build(:role, :dancer)
  end

  test "is valid with all required attributes" do
    assert @role.valid?
  end

  test "is invalid without person" do
    @role.person = nil

    assert_not @role.valid?
    assert_includes @role.errors[:person], "must exist"
  end

  test "is invalid without organization" do
    @role.organization = nil

    assert_not @role.valid?
    assert_includes @role.errors[:organization], "must exist"
  end

  test "is invalid without role type" do
    @role.role = nil

    assert_not @role.valid?
    assert_includes @role.errors[:role], "can't be blank"
  end

  test "is invalid with duplicate role for person in same organization" do
    @role.save!

    duplicate = build(:role, person: @role.person, organization: @role.organization, role: @role.role)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person], "has already been taken"
  end

  test "is valid with unique roles for person in same organization" do
    @role.save!

    unique_role = build(:role, person: @role.person, organization: @role.organization, role: :admin)

    assert unique_role.valid?
  end

  test "is valid with same role for person in different organizations" do
    @role.save!

    different_org_role = build(:role, person: @role.person, organization: create(:studio), role: @role.role)

    assert different_org_role.valid?
  end
end
