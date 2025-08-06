class StudioMembership < ApplicationRecord
  belongs_to :studio
  belongs_to :person

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
  validates :role, uniqueness: { scope: [ :studio, :person ] }
end
