class Season < ApplicationRecord
  belongs_to :studio

  has_many :season_memberships, dependent: :destroy
  has_many :people, through: :season_memberships

  validates :name, :start_year, :end_year, presence: true
  validate :start_year_not_greater_than_end_year

  def year
    start_year == end_year ? start_year.to_s : "#{start_year} - #{end_year}"
  end

  def add_dancer(person)
    if studio.people.where(id: person.id).exists?
      if person.season_memberships.where(season_id: self.id, role: :dancer).exists?
        errors.add(:base, "Person is already a dancer in this season.")
        return false
      end
    else
      errors.add(:base, "Person must be a member of the studio to be added as a dancer.")
      return false
    end

    person.season_memberships.create(role: :dancer, season: self)
  end

  def get_dancers
    self.people.where("season_memberships.role = ?", SeasonMembership.roles[:dancer])
  end

  def get_eligible_dancers
    self.studio.get_dancers.where.not(id: self.get_dancers)
  end

  def add_director(person)
    if studio.people.where(id: person.id).exists?
      if person.season_memberships.where(season_id: self.id, role: :director).exists?
        errors.add(:base, "Person is already a director in this season.")
        return false
      end
    else
      errors.add(:base, "Person must be a member of the studio to be added as a director.")
      return false
    end

    person.season_memberships.create(role: :director, season: self)
  end

  private

  def start_year_not_greater_than_end_year
    if start_year.present? && end_year.present? && start_year > end_year
      errors.add(:start_year, "cannot be greater than end year")
    end
  end
end
