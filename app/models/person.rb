class Person < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :organizations, through: :roles

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
