class GameEngine
  def self.take_turn(player, direction)
    location = MoveCalculator.calculate_move(current_x: player.x, current_y: player.y, direction: direction)

    opponents = Game.get_resources_at_location(x: location.x, y: location.y)
    if player.is_in_base?
      GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: opponents)
    else
      on_flag = false # location == player.opponent_team.flag_location
      GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: opponents, on_flag: on_flag)
    end

    player.moves.create!(x_location: location.x, y_location: location.y)
  end
end

