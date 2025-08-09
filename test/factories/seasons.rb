FactoryBot.define do
  factory :season do
    sequence(:name) { |n| "Season #{n}" }


    start_year { Date.current.year }
    end_year   { start_year + 1 }

    studio

    trait :past do
      start_year { Date.current.year - 1 }
      end_year   { start_year + 1 }
    end

    trait :future do
      start_year { Date.current.year + 1 }
      end_year   { start_year + 1 }
    end

    # Allows setting a specific year for both start and end
    transient do
      year { nil }
    end

    after(:build) do |season, evaluator|
      if evaluator.year
        season.start_year = evaluator.year
        season.end_year   = evaluator.year
      end
    end
  end
end
