class GameColliderHandler
  def self.handle_collisions(player, resources)
    resources.each do |resource|
      if resource.is_water?
        player.fill_water!(resource.amount)
      elsif resource.is_food?
        food = resource.remove_resource!(player.food_amount_needed)
        player.fill_food!(food)
      elsif resource.is_player?
        if player.strength_stat > resource.strength_stat
          food = resource.remove_food!(player.food_amount_needed)
          player.fill_food!(food)
        else
          food = player.remove_food!(resource.food_amount_needed)
          resource.fill_food!(food)
        end
      else
        raise "unknown resource"
      end
    end
  end
end