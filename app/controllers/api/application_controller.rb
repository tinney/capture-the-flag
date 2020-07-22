class Api::ApplicationController < ApplicationController
  before_action :require_player_and_name
  after_action :broadcast

  def require_player_and_name
    render(json: {error: "No Player Email passed in request header"}, :status => :bad_request) and return unless player_email
    render(json: {error: "Player not found for email #{player_email}."}, :status => :bad_request) and return unless player
    render(json: {error: "You do not have an active player for #{player_email}. Slack Dustin."}, :status => :bad_request) and return unless player.active?
  end

  def player_email
    request.headers["PLAYER_EMAIL"] || request.headers["HTTP_PLAYER_EMAIL"] || request.headers["HTTP_Player_Email"] || request.headers["HTTP_player_email"]
  end

  def player
    Player.find_by(email: player_email)
  end

  def broadcast
    GameBroadcaster.update_board
  end
end
