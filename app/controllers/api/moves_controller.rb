class Api::MovesController < Api::ApplicationController
  def create
    render(json: {error: "You do not have an active player. Update /api/player to activate your player."}, :status => :bad_request) and return unless player
    render(json: {error: "You must provide a direction (NORTH, SOUTH, EAST, WEST)."}, :status => :bad_request) and return unless direction
    render(json: {error: "Unknown direction #{direction} (NORTH, SOUTH, EAST, WEST)."}, :status => :bad_request) and return unless [NORTH, EAST, SOUTH, WEST].include?(direction)

    GameEngine.take_turn(player, direction.upcase)
    opponents = Game.get_resources_around_player(player)

    render json: {
      player: player,
      flag: player.opponent_team.flag,
      opponents: opponents,
    }

  rescue => e
    render(json: e.to_json, :status => :bad_request)
  end

  private
  def direction
    params[:direction].upcase
  end
end
