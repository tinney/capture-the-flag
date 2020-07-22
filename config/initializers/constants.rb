# 0 - 5 Flag
# 75 - 80 Flag

BOARD_WIDTH = 80 # NOTE this is also set in game.js
BOARD_HEIGHT = 40 # NOTE this is also set in game.js
FIELD_CENTER = 40
FLAG_DIVIDER = 5

MOVE_AMOUNT = 1 

NORTH = 'NORTH'.freeze
EAST = 'EAST'.freeze
SOUTH = 'SOUTH'.freeze
WEST = 'WEST'.freeze

# Player setings & abilities
DEFAULT_SIGHT_AREA = 5
SIGHT_RANGE = 10
JUKE_PERCENTAGE = 30 # 30% chance of juking and not having the peg taken

#POINTS
POINTS_FOR_FLAG_CAPTURE = 25.freeze
POINTS_FOR_FLAG_PICKUP = 5.freeze
POINTS_FOR_FLAG_RETURN = 10.freeze
POINTS_FOR_PEG_CAPTURE = 5.freeze

SLACK_CHANNEL_NAME = ENV.fetch("SLACK_CHANNEL_NAME")