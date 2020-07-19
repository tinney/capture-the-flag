# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  points     :integer          default(0)
#  field_side :integer          default("left_field")
#

class Team < ApplicationRecord
  has_many :players
  has_one :flag, -> { where.not(captured: true) }

  enum field_side: [:left_field, :right_field]

  def coordinates_in_base(x:, y:)
    if left_field?
      x < FIELD_CENTER
    else
      x >= FIELD_CENTER
    end
  end

  def max_x
    left_field? ? (FIELD_CENTER-1) : BOARD_WIDTH
  end
  
  def min_x
    left_field? ? 0 : FIELD_CENTER
  end

  def opponent
    Team.where.not(id: id).first
  end

  def is_flag_on?(x:, y:)
    flag.x_location = x && flag.y_location = y
  end

  def random_player_location
    random_player_offset = rand((BOARD_WIDTH / 2) - FLAG_DIVIDER)
    x = left_field? ? random_player_offset + FLAG_DIVIDER : BOARD_WIDTH - FLAG_DIVIDER - random_player_offset
    [x, rand(BOARD_HEIGHT)]
  end


  def random_flag_location
    # either end depending of we're home or away and Y doesn't matter
    x = left_field? ? rand(FLAG_DIVIDER) : BOARD_WIDTH - rand(FLAG_DIVIDER)
    [x, rand(BOARD_HEIGHT)] 
  end

  def hide_flag!
    location = random_flag_location
    create_flag!(x_location: location.first, y_location: location.last)
  end

  def take_flag!(opponent)
    update!(flag_holder_id: opponent.id, revealed: true)
  end

  def as_json(options = {})
    super({
      only: [],
      methods: []
    }.merge(options))
  end
end
