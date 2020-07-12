class PlayerStatsUpdater

  def self.update_for_turn(player, location)
    player.moves.create!(x_location: location.x, y_location: location.y)
    player.days_active =  player.days_active + 1

    player.x_location = location.x
    player.y_location = location.y

    player.days_without_water = days_without_water(player)
    player.days_without_food = days_without_food(player)

    player.eat if player_consumes?(player)
    player.drink

    player.active = active?(player)
    player.save!
  end

  def self.player_consumes?(player)
    # consume every X days
    0 == (player.days_active % player.stamina_stat)
  end

  def self.active?(player)
    (player.days_without_water <= MAX_DAYS_WITHOUT_WATER && player.days_without_food <= MAX_DAYS_WITHOUT_FOOD)
  end

  def self.days_without_water(player)
    if player.has_water?
      0
    else
      player.days_without_water + 1
    end
  end

  def self.days_without_food(player)
    if player.has_food?
      0
    else
      player.days_without_food + 1
    end
  end
end