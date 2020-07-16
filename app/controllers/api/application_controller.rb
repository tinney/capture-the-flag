class Api::ApplicationController < ApplicationController
  before_action :require_player_and_name

  def require_player_and_name
    render(json: {error: "No Player ID passed in request header"}, :status => :bad_request) and return unless player_id
    render(json: {error: "No Player Name passed in request header"}, :status => :bad_request) and return unless player_name
    render(json: {error: "Player not found for ID #{player_id} and name #{player_name}"}, :status => :bad_request) and return unless player
    render(json: {error: "You do not have an active player. Talk to Dustin."}, :status => :bad_request) and return unless player.active?
  end

  def player_id
    request.headers["PLAYER_ID"] || request.headers["HTTP_PLAYER"] || request.headers["HTTP_Player"] || request.headers["HTTP_player"]
  end

  def player_name
    request.headers["PLAYER_NAME"] || request.headers["HTTP_PLAYER_NAME"] || request.headers["HTTP_Player_Name"] || request.headers["HTTP_player_name"]
  end

  def player
    Player.find_by(id: player_id, name: player_name)
  end
end
