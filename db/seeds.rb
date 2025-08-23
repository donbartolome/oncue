# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(
  email_address: "admin@example.com",
  password_digest: BCrypt::Password.create("gNX$KqB3$hcLcYgN"),
)

avanti = Studio.find_or_create_by!(
  name: "Avanti Dance Company",
  address_line1: "151 Kalmus Dr",
  address_line2: "Ste J7",
  city: "Costa Mesa",
  state: "CA",
  zip_code: "92626"
)

Season.find_or_create_by!(
  name: "Season 9",
  start_year: 2023,
  end_year: 2024,
  studio: avanti
)

Season.find_or_create_by!(
  name: "Season 10",
  start_year: 2024,
  end_year: 2025,
  studio: avanti
)

Season.find_or_create_by!(
  name: "Season 11",
  start_year: 2025,
  end_year: 2026,
  studio: avanti
)

people_data = [
  {
    first_name: "Taryn",
    last_name: "Chavez",
    studio_memberships: [ { studio: avanti, role: :owner } ]
  },
  {
    first_name: "Ailah",
    last_name: "Medina",
    studio_memberships: [ { studio: avanti, role: :dancer } ]
  },
  {
    first_name: "Aurelia",
    last_name: "Coker",
    studio_memberships: [ { studio: avanti, role: :dancer } ]
  },
  {
    first_name: "Kylie Sophia",
    last_name: "Bartolome",
    studio_memberships: [ { studio: avanti, role: :dancer } ]
  }
]

people = {}

people_data.each do |attrs|
  person = Person.find_or_create_by!(
    first_name: attrs[:first_name],
    last_name: attrs[:last_name]
  )
  people[person.full_name] = person
  attrs[:studio_memberships].each do |role_attrs|
    studio = role_attrs[:studio]
    role = role_attrs[:role].to_sym

    case role
    when :owner
      studio.add_owner(person)
    when :dancer
      studio.add_dancer(person)
    else
      StudioMembership.find_or_create_by!(
        person: person,
        studio: studio,
        role: role
      )
    end
  end
end
