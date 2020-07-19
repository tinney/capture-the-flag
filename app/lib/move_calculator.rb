class MoveCalculator
  def self.calculate_move(current_x:, current_y:, direction:, field_side:)
    raise "unknown direction '#{direction}'" unless [NORTH, EAST, SOUTH, WEST].include?(direction)
    Location.new(x: calculate_x(current_x, direction), y: calculate_y(current_y, direction))
  end

  private
  def self.calculate_y(current_y, direction)
    return current_y if direction == EAST || direction == WEST
    
    new_y = direction == NORTH ? current_y - MOVE_AMOUNT : current_y + MOVE_AMOUNT

    return current_y if new_y > BOARD_HEIGHT || new_y <= 0
    return new_y
  end

  def self.calculate_x(current_x, direction)
    return current_x if direction == NORTH || direction == SOUTH

    new_x = direction == EAST ? current_x + MOVE_AMOUNT : current_x - MOVE_AMOUNT

    return current_x if new_x > BOARD_WIDTH || new_x <= 0 
    return new_x
  end

  def self.random_flag_location(field_side:)
    # either end depending of we're home or away and Y doesn't matter
    x = field_side == 'left_field' ? rand(FLAG_DIVIDER) : BOARD_WIDTH - rand(FLAG_DIVIDER)
    [x, rand(BOARD_HEIGHT)] 
  end
  
  def self.random_player_location(field_side:)
    random_player_offset = rand((BOARD_WIDTH / 2) - FLAG_DIVIDER)
    x = field_side == 'left_field' ? random_player_offset + FLAG_DIVIDER : BOARD_WIDTH - FLAG_DIVIDER - random_player_offset
    [x, rand(BOARD_HEIGHT)]
  end

  def self.coordinates_in_base(x:, field_side:)
    if field_side == 'left_field'
      x < FIELD_CENTER
    else
      x >= FIELD_CENTER
    end
  end
end