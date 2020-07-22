# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  team_id    :integer
#  name       :string
#  active     :boolean          default(TRUE), not null
#  x_location :integer          not null
#  y_location :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  has_peg    :boolean          default(TRUE)
#  icon       :string           default("💚")
#

FactoryBot.define do
  factory :player do
    team

    name { 'Player 1' }
    email { "player_#{rand(100000)}@testdouble.com" }
    ability { :sight }
    active { true }
    x_location { nil }
    y_location { nil }

    trait :inactive do
      active { false }
    end

    trait :active do
      active { true }
    end

    trait :con_peg do
      has_peg { true }
  end

    trait :sans_peg do
      has_peg { false }
    end
  end
end
