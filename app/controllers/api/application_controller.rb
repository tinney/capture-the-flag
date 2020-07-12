class Api::ApplicationController < ApplicationController
  before_action :require_team

  def require_team
    render(json: {error: "No Team ID passed in request header"}, :status => :bad_request) and return unless team_id
    render(json: {error: "Team not found for ID #{team_id}"}, :status => :bad_request) and return unless team
  end

  def team_id
    request.headers["HTTP_TEAM"] || request.headers["HTTP_Team"] || request.headers["HTTP_team"]
  end

  def team
    Team.find_by(id: team_id)
  end
end
