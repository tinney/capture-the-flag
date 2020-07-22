class GamesController < ApplicationController
  def index
    @players = Player.active.includes(:flag).all
    @players_json = @players.to_json(only: [:id, :icon], methods: [:x, :y, :has_flag, :has_peg])
  end

  def leaderboard
    @teams = Team.all
  end
end
