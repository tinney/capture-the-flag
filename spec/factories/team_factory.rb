# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_side :integer          default("left_field")
#

FactoryBot.define do
  factory :team do
    name { 'Red Team' }
    field_side { ['left_field', 'right_field'].sample }
  end
end
