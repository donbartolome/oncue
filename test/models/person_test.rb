require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = build(:person)
  end

  test "is valid with all required attributes" do
    assert @person.valid?
  end

  test "is invalid without a first name" do
    @person.first_name = nil
    assert_not @person.valid?
    assert_includes @person.errors[:first_name], "can't be blank"
  end

  test "is invalid without a last name" do
    @person.last_name = nil
    assert_not @person.valid?
    assert_includes @person.errors[:last_name], "can't be blank"
  end
end
