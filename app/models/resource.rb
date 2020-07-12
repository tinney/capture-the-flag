# == Schema Information
#
# Table name: resources
#
#  id         :bigint           not null, primary key
#  x_location :integer          default(0), not null
#  y_location :integer          default(0), not null
#  amount     :integer          default(1), not null
#  active     :boolean          default(TRUE), not null
#  is_water   :boolean          default(FALSE), not null
#  is_food    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Resource < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :on_x, -> (x) { where(x_location: x) }
  scope :on_y, -> (y) { where(y_location: y) }

  after_create :broadcast_create
  after_update :broadcast_update
  
  def as_json(options = {})
    super({
      only: [],
      methods: [:x, :y, :is_water, :is_food, :is_player]
    }.merge(options))
  end

  def is_player?
    false
  end
  
  def is_player
    false
  end

  def is_food
    is_food?
  end
  
  def is_water
    is_water?
  end

  def x
    x_location
  end

  def y
    y_location
  end

  def remove_resource!(amount_needed)
    return MAX_RESOURCE_AMOUNT if is_water?

    give_amount = [amount_needed, amount].min

    if amount_needed >= amount
      self.active = false
      self.amount = 0
    else
      self.amount -= amount_needed
    end

    save!

    return give_amount
  end

  def x
    x_location
  end

  def y
    y_location
  end

  def broadcast_create
    GameBroadcaster.broadcast_resource_created(self)
  end

  def broadcast_update
    unless self.active?
      Game.create_random_food_resource
      GameBroadcaster.broadcast_resource_destroyed(self)
    end
  end
end
