class GamesController < ApplicationController
  def index
    @players = Player.active.includes(:flag).all
    @players_json = @players.to_json(only: [:id, :icon], methods: [:x, :y, :has_flag, :has_peg])
  end

  def leaderboard
    @players = Player.active.all.includes(:awards, :team)
    @players = @players.sort_by { |p| -p.points }
    @teams = Team.all
  end

  def slack_leaderboard
    @players = Player.active.all.includes(:awards, :team)
    @players = @players.sort_by { |p| -p.points }[0..10]
    @teams = Team.all

    leaderboard = []
    leaderboard << "*LEADERBOARD*"
    leaderboard << "#{@teams.first.name} - #{@teams.first.points} vs #{@teams.last.name} has #{@teams.last.points}"
    leaderboard << " "
    leaderboard << "*Player Score Board*"
    @players.each_with_index do |player, index|
      leaderboard << "#{index + 1}. #{player.name} with #{player.points} points."
    end
    leaderboard << " "
    leaderboard << "<http://td-capture-the-flag.herokuapp.com/leaderboard|View the full leaderboard here>"

    SlackBroadcaster.broadcast_message(leaderboard.join("\n"))

    return head(:ok)
  end
end
