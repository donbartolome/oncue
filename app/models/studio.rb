class Studio < Organization
  def add_dancer(person)
    # Check if the person is already a dancer in this studio
    if person.organization_memberships.where(organization_id: self.id, role: :dancer).exists?
      errors.add(:base, "Person is already a dancer in this studio.")
      return false
    end

    person.organization_memberships.create(role: :dancer, organization: self)
  end

  def add_owner(person)
    # Check if the person is already an owner of this studio
    if person.organization_memberships.where(organization_id: self.id, role: :owner).exists?
      errors.add(:base, "Person is already an owner of this studio.")
      return false
    end

    person.organization_memberships.create(role: :owner, organization: self)
  end
end
