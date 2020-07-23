class Api::PlayersController < Api::ApplicationController
  def show
    opponents = Game.get_resources_around_player(player)
    render json: {
      player: player,
      flag: player.opponent_team.flag,
      opponents: opponents
    }
  end
end
