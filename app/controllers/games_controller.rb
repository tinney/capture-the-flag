class GamesController < ApplicationController
  def index
    @players = Player.active.all
    @players_json = @players.to_json(only: [:id, :icon], methods: [:x, :y])
  end

  def leaderboard
    @teams = Team.all
  end
end
