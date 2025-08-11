FactoryBot.define do
  factory :studio_season, class: 'Studio::Season' do
    name { "MyString" }
    start_year { 1 }
    end_year { 1 }
    studio { nil }
  end
end
