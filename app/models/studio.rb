class Studio < ApplicationRecord
  has_many :studio_memberships, dependent: :destroy
  has_many :people, through: :studio_memberships
  has_many :seasons, -> { order(end_year: :desc, start_year: :desc) }, dependent: :destroy

  validates :name, :address_line1, :city, :state, :zip_code, presence: true
  validates :name, uniqueness: { scope: [ :city, :state ], case_sensitive: false, message: "should be unique within the same city and state" }

  def add_dancer(person)
    # Check if the person is already a dancer in this studio
    if person.studio_memberships.where(studio_id: self.id, role: :dancer).exists?
      errors.add(:base, "Person is already a dancer in this studio.")
      return false
    end

    person.studio_memberships.create(role: :dancer, studio: self)
  end

  def add_owner(person)
    # Check if the person is already an owner of this studio
    if person.studio_memberships.where(studio_id: self.id, role: :owner).exists?
      errors.add(:base, "Person is already an owner of this studio.")
      return false
    end

    person.studio_memberships.create(role: :owner, studio: self)
  end

  def create_season(name, start_year, end_year)
    self.seasons.create(
      name: name,
      start_year: start_year,
      end_year: end_year
    )
  end
end
