# == Schema Information
#
# Table name: flags
#
#  id         :bigint           not null, primary key
#  captured   :boolean          default(FALSE)
#  revealed   :boolean          default(FALSE)
#  player_id  :integer
#  team_id    :integer
#  x_location :integer
#  y_location :integer
#
class Flag < ApplicationRecord
  belongs_to :team
  belongs_to :player, required: false

  scope :at_location, -> (x:, y:){ where(x_location: x, y_location: y) }
  scope :for_team, -> (team_id) { where(team_id: team_id) }


  def pickup!(player)
    update!(revealed: true, player: player)
  end

  def drop_flag!
    update!(player_id: nil)
  end

  def held?
    player_id.present?
  end

  def held
    held?
  end

  def capture!
    update!(captured: true)
  end

  def x
    x_location
  end

  def y
    y_location
  end
  
  def as_json(options = {})
    methods = revealed? ? [:held, :x, :y] : [:held]

    super({
      only: [:revealed],
      methods: methods,
    }.merge(options))
  end
end
