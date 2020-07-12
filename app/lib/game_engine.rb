class GameEngine
  def self.take_turn(player, direction)
    location = MoveCalculator.calculate_move(current_x: player.x, current_y: player.y, direction: direction)

    resources = Game.get_resources_at_location(x: location.x, y: location.y)
    GameColliderHandler.handle_collisions(player, resources)
    PlayerStatsUpdater.update_for_turn(player, location)

    if !player.active?
      Game.create_food_resource_at_location(x: player.x, y: player.y, amount: player.food_count)
    end
  end
end

