class GamesController < ApplicationController
  def index
    @players = Player.active.all
    @players_json = @players.to_json(only: [:id, :water_count, :food_count, :days_without_water, :days_without_food, :active, :days_active ], methods: [:x, :y])
    @resources = Resource.active.all
  end

  def leaderboard
    @teams = Team.all
  end
end
