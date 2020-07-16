# == Schema Information
#
# Table name: teams
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  points          :integer          default(0)
#  flag_x_location :integer
#  flag_y_location :integer
#  flag_holder_id  :integer
#  flag_found      :boolean          default(FALSE)
#  field_side      :integer          default(0)
#

FactoryBot.define do
  factory :team do
    name { 'Red Team' }
    points { 0 }
    flag_x_location { rand(10) }
    flag_y_location { rand(10) }
    flag_found { false }
    flag_holder_id { nil }

    transient do
      opponent_with_flag { nil }
    end

    before(:create) do |team, evaluator|
      if evaluator.opponent_with_flag.present?
        team.flag_holder_id = evaluator.opponent_with_flag.id
        team.flag_found = true
      end
    end
  end
end
