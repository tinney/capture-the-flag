class GameEngine
  def self.take_turn(player, direction)
    location = MoveCalculator.calculate_move(current_x: player.x, current_y: player.y, direction: direction)
    opponent_team = player.team.opponent
    opponents = Player.at_location(x: location.x, y: location.y).on_team(opponent_team.id)

    if player.is_in_base?
      GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: opponents)
    else
      on_flag = opponent_team.is_flag_on?(x: location.x, y: location.y)
      GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: opponents, on_flag: on_flag)
    end

    player.move_to!(new_x: location.x, new_y: location.y)
  end
end

