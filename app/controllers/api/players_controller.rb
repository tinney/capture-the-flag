class Api::PlayersController < Api::ApplicationController
  def show
    player = team.active_player
    render(json: { error: "no active player for team: #{team.name} #{team.id}" }, status: :bad_request) and return unless player

    resources = Game.get_resources_around_player(player)
    render json: {
      player: player.as_json(
        only: [
          :water_count,
          :food_count,
          :food_stat,
          :water_stat,
          :stamina_stat,
          :strength_stat,
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

  def create
    active_player = team.active_player
    player = team.players.new(player_params)

    if player.save
      active_player&.update(active: false)
      resources = Game.get_resources_around_player(player)

      render json: {
        player: player.as_json(
          only: [
            :food_stat,
            :water_stat,
            :stamina_stat,
            :strength_stat,
            :water_count,
            :food_count,
            :days_without_water,
            :days_without_food,
            :active,
            :days_active
          ],
          methods: [:x, :y]
        ),
        board: resources
      }
    else
      render(json: { error: player.errors.full_messages.join(', ') }, status: :bad_request)
    end
  end

  private
  def resources_for_player(player)
    Game.get_resources_around_player(player)
  end

  def player_params
    params.require(:player).permit(:name, :water_stat, :food_stat, :stamina_stat, :strength_stat)
  end
end
