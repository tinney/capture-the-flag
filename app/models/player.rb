# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  team_id    :integer
#  name       :string
#  active     :boolean          default(TRUE), not null
#  x_location :integer          not null
#  y_location :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  has_peg    :boolean          default(TRUE)
#  icon       :string           default("💚")
#

class Player < ApplicationRecord
  validates :team_id, presence: true
  belongs_to :team
  has_many :moves
  has_one :flag, -> { where(captured: false) }

  before_create :set_location


  scope :active, -> { where(active: true) }

  scope :at_location, -> (x:, y:){ where(x_location: x, y_location: y) }
  scope :on_team, -> (team_id) { where(team_id: team_id) }

  scope :within_range_of, -> (range:, x:, y:) do
    x_range = [(x-range)..(x+range)]
    y_range = [(y-range)..(y+range)]
    where(x_location: x_range, y_location: y_range)
  end

  def range
    DEFAULT_SIGHT_AREA
  end

  def is_in_base?
    team.coordinates_in_base(x: x, y: y)
  end

  def is_in_base
    is_in_base?
  end

  def as_json(options = {})
    super({
      only: [],
      methods: [:x, :y]
    }.merge(options))
  end

  def move_to!(new_x:, new_y:)
    moves.create!(x_location: new_x, y_location: new_y)
    update!(x_location: new_x, y_location: new_y)
  end

  def field_side
    team.field_side
  end

  def set_location
    location = MoveCalculator.random_player_location(field_side: field_side)

    self.x_location ||= location.first
    self.y_location ||= location.last 
  end

  def opponent_team
    team.opponent
  end

  def has_flag?
    flag.present?
  end

  def has_flag
    flag.present?
  end

  def drop_flag!
    flag.drop_flag!
  end

  def x
    x_location
  end
  
  def y
    y_location
  end

  def juke?
    # should look at attributes maybe 20 / 80 or 40 / 60?  
    return false
  end
end
