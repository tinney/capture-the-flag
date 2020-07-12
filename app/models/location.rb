class Location
  attr_reader :x, :y

  def initialize(x:, y:, water: false, food: false)
    @x = x
    @y = y
    @water = water
    @food = food
  end

  def water?
    @water
  end

  def food?
    @food
  end

  def has_player?
    false
  end

  def food_count
    0
  end
end