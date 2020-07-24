# == Schema Information
#
# Table name: games
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
  has_many :fields

  def self.get_opponents_at_location(x:, y:)
    Player.where(active: true, x_location: x, y_location: y)
  end

  def self.get_resources_around_player(player)
    Player.not_on_team(player.team_id).within_range_of(range: player.range, x: player.x, y: player.y).includes(:flag).active.where.not(id: player.id).all
  end

  def self.get_flag_around_player(player)
    Flag.for_team(player.opponent_team).within_range_of(range: player.range, x: player.x, y: player.y).active
  end
end
