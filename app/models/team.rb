# == Schema Information
#
# Table name: teams
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  points          :integer          default(0)
#  flag_x_location :integer
#  flag_y_location :integer
#  flag_holder_id  :integer
#  flag_found      :boolean          default(FALSE)
#  field_side      :integer          default(0)
#

class Team < ApplicationRecord
  has_many :players
  enum field_side: [:left_field, :right_field]

  def coordinates_in_base(x:, y:)
    if left_field?
      x < FIELD_CENTER
    else
      x >= FIELD_CENTER
    end
  end

  def opponent
    Team.where.not(id: id).first
  end

  def capture_flag!
    update!(flag_found: false, flag_holder_id: nil)
    hide_flag!
  end

  def is_flag_on?(x:, y:)
    return false if flag_held?

    x == flag_x_location && y == flag_y_location
  end

  def random_flag_location
    # either end depending of we're home or away and Y doesn't matter
    x = left_field? ? rand(FLAG_DIVIDER) : BOARD_WIDTH - rand(FLAG_DIVIDER)
    [x, rand(BOARD_HEIGHT)] 
  end

  def hide_flag!
    location = random_flag_location
    update!(flag_x_location: location.first, flag_y_location: location.last)
  end

  def flag_held?
    flag_holder_id.present?
  end

  def flag_held
    flag_held?
  end

  def random_player_location
    [rand(BOARD_WIDTH), rand(BOARD_HEIGHT)]
  end

  def take_flag!(opponent)
    update!(flag_holder_id: opponent.id, flag_found: true)
  end

  def as_json(options = {})
    attrs = flag_found? ? [:flag_y_location, :flag_x_location] : []
    super({
      only: attrs,
      methods: [:flag_held]
    }.merge(options))
  end
end
