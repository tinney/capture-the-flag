# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  has_many :players

  def max_miles
    return 0 if players.empty?
    players.order(:days_active).last.days_active || 0
  end

  def active_player
    players.active.first
  end
end
