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
#  has_peg    :boolean          default(FALSE)
#

class Player < ApplicationRecord
  validates :team_id, presence: true
  belongs_to :team
  has_many :moves

  before_create :set_location

  after_create :broadcast_create
  after_update :broadcast_update

  scope :active, -> { where(active: true) }
  scope :on_x, -> (x) { where(x_location: x) }
  scope :on_y, -> (y) { where(y_location: y) }

  def as_json(options = {})
    super({
      only: [],
      methods: [:x, :y, :is_flag, :is_player]
    }.merge(options))
  end

  def opponent_team
    Team.where.not(id: team_id).first
  end

  def is_flag?
    false
  end

  def is_flag
    false
  end

  def is_player?
    true
  end
  
  def is_player
    true
  end

  def set_location
    location = team.random_player_location

    self.x_location ||= location.first
    self.y_location ||= location.last 
    self.moves.build(x_location: x_location, y_location: y_location)
  end

  def has_flag?
    Team.where(flag_holder_id: id).exists?
  end

  def x
    x_location
  end
  
  def y
    y_location
  end
  
  private

  def broadcast_create
    GameBroadcaster.broadcast_sprite_created(self)
  end

  def broadcast_update
    GameBroadcaster.broadcast_sprite_moved(self) if self.active?
  end
end
