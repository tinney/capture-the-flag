class GameBroadcaster
  def self.update_board
    players = Player.active.includes(:team).all

    ActionCable.server.broadcast(
      "board",
      action: 'tick',
      players: players.as_json(only: [:id, :icon], methods: [:x, :y, :has_peg, :has_flag])
    )
  end
end
