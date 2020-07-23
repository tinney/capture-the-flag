class Api::ApplicationController < ApplicationController
  before_action :authenticate
  after_action :broadcast

  attr_reader :player

  def authenticate
    authenticate_with_http_token do |token, _options|
      @player = Player.find_by(email: token)
    end

    render_unauthorized and return unless @player.present?
    render_forbidden and return unless @player.active?
  end

  def render_unauthorized
    headers['WWW-Authenticate'] = %(Token realm="Application")
    error = { code: 401, message: 'Invalid player' }

    render(json: { error: error }, status: :unauthorized)
  end

  def render_forbidden
    error = { code: 403, message: 'Inactive player' }

    render(json: { error: error }, status: :forbidden)
  end

  def broadcast
    GameBroadcaster.update_board
  end
end
