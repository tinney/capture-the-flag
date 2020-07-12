class PlayerValidator < ActiveModel::Validator

  def validate(player)
    player.errors[:base] << "food_stat must be between 1 and 10." if player.food_stat.to_i <= 0 || player.food_stat > 10
    player.errors[:base] << "water_stat must be between 1 and 10." if player.water_stat.to_i <= 0 || player.water_stat > 10
    player.errors[:base] << "stamina_stat must be between 1 and 5." if player.stamina_stat.to_i <= 0 || player.stamina_stat > 5
    player.errors[:base] << "strength must be between 1 and 10." if player.strength_stat.to_i <= 0 || player.strength_stat > 10
    if player.stat_total > PLAYER_STAT_LIMIT
      player.errors[:base] << "You can only have up to #{PLAYER_STAT_LIMIT} stat points, you have #{player.stat_total}."
    end
  end
end