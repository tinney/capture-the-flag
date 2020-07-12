# == Schema Information
#
# Table name: moves
#
#  id         :bigint           not null, primary key
#  player_id  :integer
#  x_location :integer
#  y_location :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Move < ApplicationRecord

  def as_json(options = {})
    super({
      only: [],
      methods: [:x, :y,]
    }.merge(options))
  end

  def x
    x_location
  end

  def y
    y_location
  end
end
