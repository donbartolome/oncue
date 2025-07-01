FactoryBot.define do
  factory :role do
    person
    association :organization, factory: :studio
  end
end
