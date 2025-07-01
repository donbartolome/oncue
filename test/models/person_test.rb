require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = build(:person)
  end

  test "is valid with all required attributes" do
    assert @person.valid?
  end

  test "is invalid without first name" do
    @person.first_name = nil

    assert_not @person.valid?
    assert_includes @person.errors[:first_name], "can't be blank"
  end

  test "is invalid without last name" do
    @person.last_name = nil

    assert_not @person.valid?
    assert_includes @person.errors[:last_name], "can't be blank"
  end

  test "returns full name as first and last name concatenated" do
    @person.first_name = "Ada"
    @person.last_name = "Lovelace"

    assert_equal "Ada Lovelace", @person.full_name
  end
end
