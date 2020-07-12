# == Schema Information
#
# Table name: players
#
#  id                 :bigint           not null, primary key
#  team_id            :integer
#  name               :string
#  water_stat         :integer          not null
#  food_stat          :integer          not null
#  stamina_stat       :integer          not null
#  strength_stat      :integer          not null
#  active             :boolean          default(TRUE), not null
#  days_active        :integer          default(0), not null
#  days_without_water :integer          default(0), not null
#  days_without_food  :integer          default(0), not null
#  water_count        :integer          not null
#  food_count         :integer          not null
#  x_location         :integer          not null
#  y_location         :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Player < ApplicationRecord
  validates :team_id, :water_stat, :food_stat, :stamina_stat, presence: true
  validates_with PlayerValidator
  belongs_to :team
  has_many :moves

  before_create :set_location
  before_create :set_resources

  after_create :broadcast_create
  after_update :broadcast_update

  scope :active, -> { where(active: true) }
  scope :on_x, -> (x) { where(x_location: x) }
  scope :on_y, -> (y) { where(y_location: y) }

  def has_water?
    water_count > 0
  end
  
  def has_food?
    food_count > 0
  end
  
  def as_json(options = {})
    super({
      only: [],
      methods: [:x, :y, :is_water, :is_food, :is_player]
    }.merge(options))
  end

  def eat
    return unless has_food?
    self.food_count = food_count - 1
  end

  def drink 
    return unless has_water?
    self.water_count = water_count - 1
  end

  def is_water?
    false
  end

  def is_water
    false
  end

  def is_food?
    false
  end

  def is_food
    false
  end

  def is_player?
    true
  end
  
  def is_player
    true
  end

  def set_location
    self.x_location ||= rand(BOARD_WIDTH)
    self.y_location ||= rand(BOARD_HEIGHT)
    self.moves.build(x_location: x_location, y_location: y_location)
  end

  def set_resources
    self.food_count ||= self.food_stat
    self.water_count ||= self.water_stat
  end

  def has_location?
    x && y
  end

  def stat_total
    water_stat.to_i + food_stat.to_i + stamina_stat.to_i + strength_stat.to_i
  end

  def update_location!(location)
  end

  def x
    x_location
  end
  
  def y
    y_location
  end

  def increase_days_active!
    update!(days_active: 1 + days_active)
  end

  def fill_water!(water_amount)
    update!(water_count: [water_stat, water_count + water_amount].min)
  end
  
  def fill_food!(food_amount)
    update! food_count: [food_stat, food_count + food_amount].min
  end

  def remove_food!(amount_needed)
    give_amount = [amount_needed, food_count].min
    new_food_count = [0, (food_count - give_amount)].max

    update!(food_count: new_food_count)
    return give_amount
  end

  def food_amount_needed
    food_stat - food_count
  end

  def is_water?
    false
  end
  
  def is_food?
    false
  end
  
  def is_player?
    true
  end

  def broadcast_create
    GameBroadcaster.broadcast_player_created(self)
  end

  def broadcast_update
    GameBroadcaster.broadcast_player_moved(self) if self.active?
    GameBroadcaster.broadcast_player_died(self) unless self.active?
  end
end
