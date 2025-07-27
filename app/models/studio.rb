class Studio < Organization
  def add_dancer(person)
    # Check if the person is already a dancer in this studio
    if person.roles.where(organization_id: self.id, role: :dancer).exists?
      errors.add(:base, "Person is already a dancer in this studio.")
      return false
    end

    person.roles.create(role: :dancer, organization: self)
  end

  def add_owner(person)
    # Check if the person is already an owner of this studio
    if person.roles.where(organization_id: self.id, role: :owner).exists?
      errors.add(:base, "Person is already an owner of this studio.")
      return false
    end

    person.roles.create(role: :owner, organization: self)
  end
end
