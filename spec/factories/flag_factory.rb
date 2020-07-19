# == Schema Information
#
# Table name: flags
#
#  id         :bigint           not null, primary key
#  captured   :boolean          default(FALSE)
#  revealed   :boolean          default(FALSE)
#  player_id  :integer
#  team_id    :integer
#  x_location :integer
#  y_location :integer
#
FactoryBot.define do
  factory :flag do
    team
    x_location { rand(10) }
    y_location { rand(10) }
    revealed { false }
    player_id { nil }
  end
end
