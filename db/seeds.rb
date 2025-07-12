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

taryn = Person.find_or_create_by!(
  first_name: "Taryn",
  last_name: "Chavez"
)

Role.find_or_create_by!(
  person: taryn,
  organization: avanti,
  role: :owner
)

kylie = Person.find_or_create_by!(
  first_name: "Kylie Sophia",
  last_name: "Bartolome"
)

Role.find_or_create_by!(
  person: kylie,
  organization: avanti,
  role: :dancer
)
