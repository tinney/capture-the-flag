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
    MoveCalculator.coordinates_in_base(x: x, field_side: field_side)
  end

  def opponent
    Team.where.not(id: id).first
  end

  def is_flag_on?(x:, y:)
    flag.x_location = x && flag.y_location = y
  end

  def hide_flag!
    location = MoveCalculator.random_flag_location(field_side: field_side)
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
