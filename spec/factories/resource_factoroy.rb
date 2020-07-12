FactoryBot.define do
  factory :resource do
    x_location { 10 }
    y_location { 10 }
    active { true }
    is_water { true }
    is_food { false }
    amount { 100 }

    trait :water do
      is_water { true }
      is_food { false }
    end

    trait :food do
      is_water { false }
      is_food { true }
    end

    trait :inactive do
      active { false }
    end

    trait :active do
      active { true }
    end
  end
end
