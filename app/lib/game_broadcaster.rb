class GameBroadcaster
  def self.update_board
    players = Player.active.includes(:flag).all
    teams = Team.includes(:awards).all

    ActionCable.server.broadcast(
      "board",
      action: 'tick',
      players: players.as_json(only: [:id, :icon], methods: [:x, :y, :has_peg, :has_flag]), 
      teams: teams.as_json(methods: [:points, :field_side])
    )
  end
end
