# == Schema Information
#
# Table name: players
#
#  id                 :bigint           not null, primary key
#  team_id            :integer
#  name               :string
#  water_stat         :integer          not null
#  food_stat          :integer          not null
#  stamina_stat       :integer          not null
#  strength_stat      :integer          not null
#  active             :boolean          default(TRUE), not null
#  days_active        :integer          default(0), not null
#  days_without_water :integer          default(0), not null
#  days_without_food  :integer          default(0), not null
#  water_count        :integer          not null
#  food_count         :integer          not null
#  x_location         :integer          not null
#  y_location         :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :player do
    association :team
    name { 'Player 1' }
    water_stat { 5 }
    food_stat { 5 } 
    stamina_stat { 5 }
    strength_stat { 5 }
    active { true }
    x_location { nil }
    y_location { nil }
    water_count { nil }
    food_count { nil }

    trait :inactive do
      active { false }
    end

    trait :active do
      active { true }
    end
  end
end
