class Studio < ApplicationRecord
  has_many :studio_memberships, dependent: :destroy
  has_many :people, through: :studio_memberships

  def add_dancer(person)
    # Check if the person is already a dancer in this studio
    if person.studio_memberships.where(studio_id: self.id, role: :dancer).exists?
      errors.add(:base, "Person is already a dancer in this studio.")
      return false
    end

    person.studio_memberships.create(role: :dancer, organization: self)
  end

  def add_owner(person)
    # Check if the person is already an owner of this studio
    if person.studio_memberships.where(studio_id: self.id, role: :owner).exists?
      errors.add(:base, "Person is already an owner of this studio.")
      return false
    end

    person.studio_memberships.create(role: :owner, organization: self)
  end
end
