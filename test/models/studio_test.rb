require "test_helper"

class StudioTest < ActiveSupport::TestCase
  def setup
    @studio = build(:studio)
  end

  test "is valid with all required attributes" do
    assert @studio.valid?
  end

  test "is invalid without a name" do
    @studio.name = nil
    assert_not @studio.valid?
    assert_includes @studio.errors[:name], "can't be blank"
  end

  test "is invalid with a duplicate name in the same city and state" do
    @studio.save!
    duplicate = build(:studio, name: @studio.name, city: @studio.city, state: @studio.state)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "should be unique within the same city and state"
  end

  test "is valid with a duplicate name in a different city" do
    @studio.save!
    other_city = build(:studio, name: @studio.name, city: "DifferentCity", state: @studio.state)
    assert other_city.valid?
  end

  test "is valid with a duplicate name in a different state" do
    @studio.save!
    other_state = build(:studio, name: @studio.name, city: @studio.city, state: "ZZ")
    assert other_state.valid?
  end

  test "is invalid without address_line1" do
    @studio.address_line1 = nil
    assert_not @studio.valid?
    assert_includes @studio.errors[:address_line1], "can't be blank"
  end

  test "is invalid without city" do
    @studio.city = nil
    assert_not @studio.valid?
    assert_includes @studio.errors[:city], "can't be blank"
  end

  test "is invalid without state" do
    @studio.state = nil
    assert_not @studio.valid?
    assert_includes @studio.errors[:state], "can't be blank"
  end

  test "is invalid without zip_code" do
    @studio.zip_code = nil
    assert_not @studio.valid?
    assert_includes @studio.errors[:zip_code], "can't be blank"
  end
end
