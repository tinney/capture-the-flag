class Api::PlayersController < Api::ApplicationController
  def show
    render(json: {error: "You do not have an active player. Update /api/player to activate your player."}, :status => :bad_request) and return unless player

    opponents = Game.get_resources_around_player(player)
    render json: {
      player: player,
      flag: player.opponent_team.flag,
      opponents: opponents
    }
  end
end
