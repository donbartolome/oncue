class StudioMembership < ApplicationRecord
  belongs_to :studio
  belongs_to :person

  enum :role, {
    owner: 0,
    admin: 1,
    staff: 2,
    director: 3,
    instructor: 4,
    choreographer: 5,
    parent: 6,
    dancer: 7
  }

  validates :role, presence: true
  validates :person, uniqueness: { scope: [ :studio, :role ] }
end
