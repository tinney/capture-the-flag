class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  after_action :broadcast

  def broadcast
    GameBroadcaster.update_board
  end
end
