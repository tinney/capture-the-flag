class PlayersController < ApplicationController
  def create
    @team = team
    @player = @team.players.new(player_params)

    if @player.save 
      redirect_to team_path(@team)
    else
      render "new"
    end
  end

  def update
    @team = team
    @player = Player.find(params[:id])

    if @player.update(player_params)
      redirect_to team_path(@team)
    else
      render "edit"
    end
  end

  def index
    @team = team
    @players = @team.players
  end

  def new
    @team = team
    @player = Player.new
  end

  def edit
    @team = team
    @player = Player.find(params[:id])
  end

  def show
    @team = team
    @player = Player.find(params[:id])
  end

  private
  def player_params
    params.require(:player).permit(:name, :email, :icon, :active)
  end

  def team
    Team.find params[:team_id]
  end
end
