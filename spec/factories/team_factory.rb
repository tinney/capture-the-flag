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
#

FactoryBot.define do
  factory :team do
    name { 'Red Team' }
    points { 0 }
  end
end
