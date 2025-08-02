FactoryBot.define do
  factory :studio_membership do
    person
    studio
    role { :dancer }
  end
end
