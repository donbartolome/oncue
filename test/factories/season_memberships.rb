FactoryBot.define do
  factory :season_membership do
    season
    person
    role { :dancer }

    trait :director do
      role { :director }
    end

    trait :instructor do
      role { :instructor }
    end

    trait :choreographer do
      role { :choreographer }
    end

    trait :dancer do
      role { :dancer }
    end
  end
end
