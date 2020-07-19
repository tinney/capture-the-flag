class Api::MovesController < Api::ApplicationController
  def create
    render(json: {error: "You do not have an active player. Update /api/player to activate your player."}, :status => :bad_request) and return unless player

    GameEngine.take_turn(player, direction.upcase)
    resources = Game.get_resources_around_player(player)

    render json: {
      player: player.as_json(
        only: [
          :active,
          :has_peg,
        ],
        methods: [:x, :y, :has_flag, :is_in_base]
      ),
      flag: player.opponent_team.flag,
      opponents: resources,
    }
  end

  private
  def direction
    params[:direction]
  end
end
