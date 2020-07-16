class GameColliderHandler
  class << self
    def handle_in_team_base_collisions(player:, opponents:)
      return unless opponents.present? || player.has_flag?

      capture_flag!(player) if player.has_flag?

      opponents.each do |opponent|
        replace_team_flag!(player.team) if opponent.has_flag?
        remove_peg!(opponent) if opponent.has_peg?
      end
    end

    def handle_in_opponent_base_collisions(player:, opponents:, on_flag:)
      return unless opponents.present? || on_flag

      pickup_flag!(player.opponent_team, player) if on_flag

      opponents.each do |opponent|
        remove_peg!(player) if opponent.has_peg?
      end
    end

    private

    def capture_flag!(player)
      player.opponent_team.capture_flag!
      award_points(player.team, POINTS_FOR_FLAG_CAPTURE)
    end

    def pickup_flag!(team, player)
      team.update!(flag_found: true, flag_holder_id: player.id)
    end

    def replace_team_flag!(team)
      team.update!(flag_holder_id: nil)
      award_points(team, POINTS_FOR_FLAG_RETURN)
    end

    def remove_peg!(player)
      player.update!(has_peg: false)
      award_points(player.opponent_team, POINTS_FOR_PEG_CAPTURE)
    end

    def award_points(team, points)
      team.update!(points: team.points + points)
    end
  end
end