class SeasonMembership < ApplicationRecord
  belongs_to :season
  belongs_to :person

  enum :role, {
    director: 0,
    instructor: 1,
    choreographer: 2,
    dancer: 3
  }

  validates :role, presence: true
  validates :person, uniqueness: { scope: [ :season, :role ] }
end
