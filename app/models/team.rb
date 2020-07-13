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
#

class Team < ApplicationRecord
  has_many :players
  has_one :flag_holder

  def max_miles
    return 0 if players.empty?
    players.order(:days_active).last.days_active || 0
  end

  def capture_flag!
    update!(flag_found: false, flag_holder_id: nil)
    hide_flag!
  end

  def active_player
    players.active.first
  end

  def hide_flag!
  end

  def place_flag
  end

  def flag_held?
    flag_holder_id.present?
  end

  def random_player_location
    [rand(BOARD_WIDTH), rand(BOARD_HEIGHT)]
  end

  def take_flag!(opponent)
    update!(flag_holder_id: opponent.id, flag_found: true)
  end
end
