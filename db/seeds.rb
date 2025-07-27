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

people_data = [
  {
    first_name: "Taryn",
    last_name: "Chavez",
    roles: [ { organization: avanti, role: :owner } ]
  },
  {
    first_name: "Ailah",
    last_name: "Medina",
    roles: [ { organization: avanti, role: :dancer } ]
    # add more associations here as needed
  },
  {
    first_name: "Aurelia",
    last_name: "Coker",
    roles: [ { organization: avanti, role: :dancer } ]
  },
  {
    first_name: "Kylie Sophia",
    last_name: "Bartolome",
    roles: [ { organization: avanti, role: :dancer } ]
  }
  # ...add more people as needed...
]

people = {}

people_data.each do |attrs|
  person = Person.find_or_create_by!(
    first_name: attrs[:first_name],
    last_name: attrs[:last_name]
  )
  people[person.full_name] = person
  attrs[:roles].each do |role_attrs|
    org = role_attrs[:organization]
    role = role_attrs[:role].to_sym

    case role
    when :owner
      org.add_owner(person)
    when :dancer
      org.add_dancer(person)
    else
      Role.find_or_create_by!(
        person: person,
        organization: org,
        role: role
      )
    end
  end
  # Add other associations here if needed, using attrs
end

# Example: Access a person for further associations
# people["Ailah Medina"].some_other_association.create!(...)
