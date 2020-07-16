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
    Player.within_range_of(range: player.range, x: player.x, y: player.y).active.where.not(id: player.id).all
  end
  
  def self.create_flag(team_id)
    x_location = rand(1...BOARD_WIDTH)
    y_location = rand(1...BOARD_HEIGHT)

    Flag.create!(team_id: team_id, x_location: x_location, y_location: y_location)
  end
end
