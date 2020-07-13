class Api::MovesController < Api::ApplicationController
  def create
    render(json: {error: "You do not have an active player. Post to /api/players to create a new player."}, :status => :bad_request) and return unless player

    GameEngine.take_turn(player, direction.upcase)
    resources = Game.get_resources_around_player(player)

    render json: {
      player: player.as_json(
        only: [
          :has_peg,
        ],
        methods: [:x, :y]
      ),
      board: resources,
    }
  end

  private
  def direction
    params[:direction]
  end
end
