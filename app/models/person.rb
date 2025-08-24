class Person < ApplicationRecord
  has_many :studio_memberships, dependent: :destroy
  has_many :studios, through: :studio_memberships
  has_many :season_memberships, dependent: :destroy
  has_many :seasons, through: :season_memberships

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
