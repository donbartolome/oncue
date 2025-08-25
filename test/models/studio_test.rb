require "test_helper"

class StudioTest < ActiveSupport::TestCase
  def setup
    @studio = build(:studio)
  end

  test "is valid with all required attributes" do
    assert @studio.valid?
  end

  test "is invalid without name" do
    @studio.name = nil

    assert_not @studio.valid?
    assert_includes @studio.errors[:name], "can't be blank"
  end

  test "is valid with duplicate name in different state" do
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

  test "is invalid with duplicate name in same city and state" do
    @studio.save!

    duplicate = build(:studio, name: @studio.name, city: @studio.city, state: @studio.state)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "should be unique within the same city and state"
  end

  test "is valid with duplicate name in different city" do
    @studio.save!

    other_city = build(:studio, name: @studio.name, city: "DifferentCity", state: @studio.state)

    assert other_city.valid?
  end

  test "add_dancer adds dancer role for person" do
    @studio.save!

    person = create(:person)

    assert_difference -> { person.studio_memberships.where(studio: @studio, role: :dancer).count }, 1 do
      result = @studio.add_dancer(person)

      assert result.persisted?
      assert_equal :dancer, result.role.to_sym
      assert_equal @studio, result.studio
    end
  end

  test "add_dancer does not add duplicate dancer role" do
    @studio.save!

    person = create(:person)
    @studio.add_dancer(person)

    assert_no_difference -> { person.studio_memberships.where(studio: @studio, role: :dancer).count } do
      result = @studio.add_dancer(person)

      assert_equal false, result
      assert_includes @studio.errors[:base], "Person is already a dancer in this studio."
    end
  end

  test "add_director adds director role for person" do
    @studio.save!

    person = create(:person)

    assert_difference -> { person.studio_memberships.where(studio: @studio, role: :director).count }, 1 do
      result = @studio.add_director(person)

      assert result.persisted?
      assert_equal :director, result.role.to_sym
      assert_equal @studio, result.studio
    end
  end

  test "add_director does not add duplicate director role" do
    @studio.save!

    person = create(:person)
    @studio.add_director(person)

    assert_no_difference -> { person.studio_memberships.where(studio: @studio, role: :director).count } do
      result = @studio.add_director(person)

      assert_equal false, result
      assert_includes @studio.errors[:base], "Person is already a director of this studio."
    end
  end

  test "add_owner adds owner role for person" do
    @studio.save!

    person = create(:person)

    assert_difference -> { person.studio_memberships.where(studio: @studio, role: :owner).count }, 1 do
      result = @studio.add_owner(person)

      assert result.persisted?
      assert_equal :owner, result.role.to_sym
      assert_equal @studio, result.studio
    end
  end

  test "add_owner does not add duplicate owner role" do
    @studio.save!

    person = create(:person)
    @studio.add_owner(person)

    assert_no_difference -> { person.studio_memberships.where(studio: @studio, role: :owner).count } do
      result = @studio.add_owner(person)

      assert_equal false, result
      assert_includes @studio.errors[:base], "Person is already an owner of this studio."
    end
  end

  test "get_dancers returns only dancers for the studio" do
    @studio.save!

    dancer1 = create(:person)
    dancer2 = create(:person)
    director = create(:person)
    @studio.add_dancer(dancer1)
    @studio.add_dancer(dancer2)
    @studio.add_director(director)

    dancers = @studio.get_dancers
    assert_includes dancers, dancer1
    assert_includes dancers, dancer2
    assert_not_includes dancers, director
    assert_equal 2, dancers.count
  end
end
