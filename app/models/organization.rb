class Organization < ApplicationRecord
  has_many :organization_memberships, dependent: :destroy
  has_many :people, through: :organization_memberships

  validates :type, :name, :address_line1, :city, :state, :zip_code, presence: true
  validates :name, uniqueness: { scope: [ :city, :state ], case_sensitive: false, message: "should be unique within the same city and state" }
end
