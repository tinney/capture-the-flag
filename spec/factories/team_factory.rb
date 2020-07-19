# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  points     :integer          default(0)
#  field_side :integer          default("left_field")
#

FactoryBot.define do
  factory :team do
    name { 'Red Team' }
    points { 0 }
  end
end
