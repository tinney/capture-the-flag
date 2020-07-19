# == Schema Information
#
# Table name: awards
#
#  id         :bigint           not null, primary key
#  event      :string
#  team_id    :integer
#  player_id  :integer
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Award < ApplicationRecord
  belongs_to :player
  belongs_to :team

  def self.captured_peg(player)
    create!(player: player, team: player.team, event: 'Peg Capture', points: POINTS_FOR_PEG_CAPTURE)
  end

  def self.returned_flag(player)
    create!(player: player, team: player.team, event: 'Flag Return', points: POINTS_FOR_FLAG_RETURN)
  end

  def self.flag_pickup(player)
    create!(player: player, team: player.team, event: 'Flag Pickup', points: POINTS_FOR_FLAG_PICKUP)
  end

  def self.flag_capture(player)
    create!(player: player, team: player.team, event: 'Flag Capture', points: POINTS_FOR_FLAG_CAPTURE)
  end

  def self.grant_achievements
    # determine any achievements made 
  end
end
