class GameColliderHandler
  # Class should know NOTHING about X & Y

  class << self
    def handle_in_team_base_collisions(player:, opponents:)
      capture_flag!(player.flag) 
      replace_peg!(player)
      opponents.each { |opponent| collide(player: opponent, grabber: player) }
    end

    def handle_in_opponent_base_collisions(player:, opponents:, flag:)
      pickup_flag!(flag, player)
      opponents.each { |opponent| collide(player: player, grabber: opponent) }
    end

    private

    def collide(player:, grabber:) 
      unless player.juke?
        remove_peg!(player: player, grabber: grabber)
        drop_flag!(player: player, grabber: grabber)
      end
    end

    def replace_peg!(player)
      return if player.has_peg?

      player.update!(has_peg: true)
    end

    def capture_flag!(flag)
      return unless flag

      flag.capture!
      flag.team.hide_flag!

      Award.flag_capture(flag.player)
    end

    def pickup_flag!(flag, player)
      return unless flag 
      return unless player.has_peg?
      return if flag.held?

      flag.pickup!(player)
      Award.flag_pickup(player)
    end

    def drop_flag!(player:, grabber:)
      return unless player.has_flag?
      player.drop_flag!

      Award.returned_flag(grabber)
    end

    def remove_peg!(player:, grabber:)
      return unless player.has_peg?
      player.update!(has_peg: false)

      Award.captured_peg(grabber)
    end
  end
end