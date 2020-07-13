class Api::PlayersController < Api::ApplicationController
  def show
    render(json: { error: "no active player found" }, status: :bad_request) and return unless player

    render json: {
      player: player.as_json(
        only: [
          :active,
          :has_peg
        ],
        methods: [:x, :y]
      ),
      board: resources_near_me,
    }
  end

  private
  def resources_near_me
    Game.get_resources_around_player(player)
  end
end
