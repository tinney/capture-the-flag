# TODO this should go away
class MovesController < ApplicationController
  def new
    render(json: {error: "Player not active."}, :status => :bad_request) and return unless player.active?
    @player = player
  end

  def create
    render(json: {error: "Player not active."}, :status => :bad_request) and return unless player.active?
    GameEngine.take_turn(player, direction)

    @player = player
    @resources = Game.get_resources_around_player(@player)

    render :new
  end

  private
  def direction
    params[:direction].upcase
  end
end
