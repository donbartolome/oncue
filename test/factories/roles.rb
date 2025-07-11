FactoryBot.define do
  factory :role do
    person { nil }
    organization { nil }
    role { 1 }
  end
end
