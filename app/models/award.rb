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
    award = create!(player: player, team: player.team, event: 'Peg Capture', points: POINTS_FOR_PEG_CAPTURE)
    SlackBroadcaster.broadcast_award(award)
  end

  def self.returned_flag(player)
    award = create!(player: player, team: player.team, event: 'Flag Return', points: POINTS_FOR_FLAG_RETURN)
    SlackBroadcaster.broadcast_award(award)
  end

  def self.flag_pickup(player)
    award = create!(player: player, team: player.team, event: 'Flag Pickup', points: POINTS_FOR_FLAG_PICKUP)
    SlackBroadcaster.broadcast_award(award)
  end

  def self.flag_capture(player)
    award = create!(player: player, team: player.team, event: 'Flag Capture', points: POINTS_FOR_FLAG_CAPTURE)
    SlackBroadcaster.broadcast_award(award)
  end

  def self.grant_achievements
    # determine any achievements made 
  end

  def message
    "#{team.name} awarded #{points} points for a #{event} by #{player.name} they now have #{team.points} points."
  end
end
