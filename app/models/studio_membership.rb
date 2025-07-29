class StudioMembership < ApplicationRecord
  belongs_to :person
  belongs_to :studio

  enum :role, {
    owner: 0,
    admin: 1,
    staff: 2,
    instructor: 3,
    choreographer: 4,
    parent: 5,
    dancer: 6
  }

  validates :role, presence: true
  validates :person, uniqueness: { scope: [ :studio, :role ] }
end
