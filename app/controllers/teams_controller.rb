class TeamsController < ApplicationController
  def create
    @team = Team.new(team_params)
    if @team.save 
      redirect_to(@team)
    else
      render "new"
    end
  end

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def show
    @team = Team.find(params[:id])
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end
