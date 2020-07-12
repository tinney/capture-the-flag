class MoveCalculator
  def self.calculate_move(current_x:, current_y:, direction:)
    raise "unknown direction '#{direction}'" unless [NORTH, EAST, SOUTH, WEST].include?(direction)
    Location.new(x: calculate_x(current_x, direction), y: calculate_y(current_y, direction))
  end

  private
  def self.calculate_y(current_y, direction)
    new_y = 1 

    return current_y if direction == EAST || direction == WEST

    new_y = direction == NORTH ? current_y - MOVE_AMOUNT : current_y + MOVE_AMOUNT

    return 1 if new_y > BOARD_HEIGHT
    return BOARD_HEIGHT - MOVE_AMOUNT if new_y <= 0
    return new_y
  end

  def self.calculate_x(current_x, direction)
    new_x = 1

    return current_x if direction == NORTH || direction == SOUTH

    new_x = direction == EAST ? current_x + MOVE_AMOUNT : current_x - MOVE_AMOUNT

    return 1 if new_x > BOARD_WIDTH
    return BOARD_WIDTH - MOVE_AMOUNT if new_x <= 0 
    return new_x
  end
end