class Api::MovesController < Api::ApplicationController
  def create
    player = team_active_player

    render(json: {error: "You do not have an active player. Post to /api/players to create a new player."}, :status => :bad_request) and return unless player

    GameEngine.take_turn(player, direction.upcase)
    resources = Game.get_resources_around_player(player)

    render json: {
      player: player.as_json(
        only: [
          :water_count,
          :food_count,
          :days_without_water,
          :days_without_food,
          :active,
          :days_active
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

  def team_active_player
    team.active_player
  end
end
