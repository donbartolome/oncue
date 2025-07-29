class Person < ApplicationRecord
  has_many :studio_memberships, dependent: :destroy
  has_many :studios, through: :studio_memberships

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
