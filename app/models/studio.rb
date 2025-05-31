class Studio < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
