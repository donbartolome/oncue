FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.unique.email }
    password_digest { BCrypt::Password.create("password") }

    # trait :admin do
    #   # Add any admin-specific attributes here if needed
    # end
  end
end
