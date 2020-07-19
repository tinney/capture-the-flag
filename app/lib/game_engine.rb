class GameEngine
  def self.take_turn(player, direction)
    location = MoveCalculator.calculate_move(current_x: player.x, current_y: player.y, direction: direction, field_side: player.team.field_side)
    opponent_team = player.team.opponent
    flag = Flag.for_team(opponent_team.id).at_location(x: location.x, y: location.y).first
    opponents = Player.at_location(x: location.x, y: location.y).on_team(opponent_team.id)

    if player.is_in_base?
      GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: opponents)
    else
      GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: opponents, flag: flag)
    end

    player.move_to!(new_x: location.x, new_y: location.y)
    Award.grant_achievements
  end
end

