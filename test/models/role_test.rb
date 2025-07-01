require "test_helper"

class RoleTest < ActiveSupport::TestCase
  def setup
    @role = build(:role, :dancer)
  end

  test "is valid with all required attributes" do
    assert @role.valid?
  end

  test "is invalid without a person" do
    @role.person = nil
    assert_not @role.valid?
    assert_includes @role.errors[:person], "must exist"
  end

  test "is invalid without an organization" do
    @role.organization = nil
    assert_not @role.valid?
    assert_includes @role.errors[:organization], "must exist"
  end

  test "is invalid without a role" do
    @role.role = nil
    assert_not @role.valid?
    assert_includes @role.errors[:role], "can't be blank"
  end

  test "is invalid with a person having the same role in the same organization" do
    @role.save!
    duplicate = build(:role, person: @role.person, organization: @role.organization, role: @role.role)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person], "has already been taken"
  end

  test "is valid with a person having multiple unique roles in the same organization" do
    @role.save!
    unique_role = build(:role, person: @role.person, organization: @role.organization, role: :admin)
    assert unique_role.valid?
  end

  test "is valid with a person having the same role in different organizations" do
    @role.save!
    different_org_role = build(:role, person: @role.person, organization: create(:studio), role: @role.role)
    assert different_org_role.valid?
  end
end
