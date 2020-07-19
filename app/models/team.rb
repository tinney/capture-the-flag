# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_side :integer          default("left_field")
#

class Team < ApplicationRecord
  has_many :players
  has_one :flag, -> { where.not(captured: true) }
  has_many :awards

  enum field_side: [:left_field, :right_field]

  def opponent
    Team.where.not(id: id).first
  end

  def hide_flag!
    location = MoveCalculator.random_flag_location(field_side: field_side)
    create_flag!(x_location: location.first, y_location: location.last)
  end

  def as_json(options = {})
    super({
      only: [],
      methods: []
    }.merge(options))
  end

  def points
    awards.sum(:points)
  end
end
