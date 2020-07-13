class Api::ApplicationController < ApplicationController
  before_action :require_team

  def require_team
    render(json: {error: "No Player ID passed in request header"}, :status => :bad_request) and return unless player_id
    render(json: {error: "Player not found for ID #{player_id}"}, :status => :bad_request) and return unless team
  end

  def player_id
    request.headers["HTTP_PLAYER"] || request.headers["HTTP_Player"] || request.headers["HTTP_player"]
  end

  def player
    Player.find_by(id: player_id)
  end
end
