class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_create :broadcast
  after_update :broadcast

  private
  def broadcast
    GameBroadcaster.update_board
  end
end
