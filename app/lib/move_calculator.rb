class MoveCalculator
  class << self
    def calculate_move(current_x:, current_y:, direction:, field_side:)
      raise "unknown direction '#{direction}'" unless [NORTH, EAST, SOUTH, WEST].include?(direction)
      # we could raise here as well if we wanted to return a better message for invalid locations

      location = Location.new(x: calculate_x(current_x, direction), y: calculate_y(current_y, direction))
      valid_location(location, field_side) ? location : Location.new(x: current_x, y: current_y)
    end

    def valid_location(location, field_side)
      y_range = 0...BOARD_HEIGHT
      x_range = field_side == 'left_field' ? FLAG_DIVIDER...BOARD_WIDTH : 0..(BOARD_WIDTH - FLAG_DIVIDER)

      x_range.include?(location.x) && y_range.include?(location.y)
    end

    def calculate_y(current_y, direction)
      return current_y if direction == EAST || direction == WEST
      direction == NORTH ? current_y - MOVE_AMOUNT : current_y + MOVE_AMOUNT
    end

    def calculate_x(current_x, direction)
      return current_x if direction == NORTH || direction == SOUTH
      direction == EAST ? current_x + MOVE_AMOUNT : current_x - MOVE_AMOUNT
    end

    def random_flag_location(field_side:)
      # either end depending of we're home or away and Y doesn't matter
      x = field_side == 'left_field' ? rand(FLAG_DIVIDER) : BOARD_WIDTH - rand(FLAG_DIVIDER)
      [x, rand(BOARD_HEIGHT)] 
    end
    
    def random_player_location(field_side:)
      random_player_offset = rand((BOARD_WIDTH / 2) - FLAG_DIVIDER)
      x = field_side == 'left_field' ? random_player_offset + FLAG_DIVIDER : BOARD_WIDTH - FLAG_DIVIDER - random_player_offset
      [x, rand(BOARD_HEIGHT)]
    end

    def coordinates_in_base(x:, field_side:)
      if field_side == 'left_field'
        x < FIELD_CENTER
      else
        x >= FIELD_CENTER
      end
    end
  end
end