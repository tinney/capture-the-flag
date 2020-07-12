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
  def self.get_resources_at_location(x:, y:)
    Resource.where(active: true, x_location: x, y_location: y) + Player.where(active: true, x_location: x, y_location: y).all
  end

  def self.get_resources_around_player(player)
    x = player.x
    y = player.y

    Resource.on_x(x).or(Resource.on_y(y)).active.all +
    Player.on_x(x).or(Player.on_y(y)).active.where.not(id: player.id).all
  end

  def self.create_food_resource_at_location(x:, y:, amount:)
    return if amount <= 0

    Resource.create!(x_location: x, y_location: y, is_food: true, is_water: false, amount: amount)
  end
  
  def self.create_random_food_resource
    x_location = rand(1...BOARD_WIDTH)
    y_location = rand(1...BOARD_HEIGHT)
    amount = rand(MAX_FOOD_AMOUNT)

    Resource.create!(x_location: x_location, y_location: y_location, is_food: true, is_water: false, amount: amount)
  end
end
