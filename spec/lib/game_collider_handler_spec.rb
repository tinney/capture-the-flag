require 'rails_helper'

RSpec.describe 'GameColliderHandler' do
  let(:team) { create(:team) }
  let(:opponent_team) { create(:team) }
  let(:player) { create(:player, :con_peg, team: team) }
  let(:opponent) { create(:player, :con_peg, team: opponent_team) }

  describe '#handle_in_opponent_base_collisions' do 
    context 'when a player moves to an empty square' do
      it 'is a no-op' do
        GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [], on_flag: false)

        expect(player.has_peg?).to equal(true)
        expect(player.has_flag?).to equal(false)
        expect(team.points).to equal(0)
        expect(opponent_team.points).to equal(0)
      end
    end

    context 'w/ a peg' do
      let(:player) { create(:player, :con_peg, team: team) }
      
      context 'when a player moves onto an opponent' do
      end

      context 'when a player moves onto the opponents flag' do
        it 'picks up the flag' do
          expect(player.has_flag?).to equal(false)
          expect(opponent_team.flag_found?).to equal(false)
          expect(opponent_team.flag_held?).to equal(false)

          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: true)

          expect(player.has_flag?).to equal(true)
          opponent_team.reload
          expect(opponent_team.flag_found?).to equal(true)
          expect(opponent_team.flag_held?).to equal(true)
        end
      end
    end
    
    context 'w/o a peg' do
      let(:player) { create(:player, :sans_peg, team: team) }

      context 'when a player moves onto an opponent' do
        it 'is a no-op' do
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: false)

          expect(player.has_peg?).to equal(false)
          expect(player.has_flag?).to equal(false)
          expect(team.points).to equal(0)
          expect(opponent_team.points).to equal(0)
        end
      end
    end
  end

  describe '#handle_in_team_base_collisions' do
    context 'when a player moves to an empty square' do
      it 'is a no-op' do
        GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [])

        expect(player.has_peg?).to equal(true)
        expect(player.has_flag?).to equal(false)
        expect(team.points).to equal(0)
      end

      context 'when the player has the flag' do
        it 'awards the ponits and resets the opponents flag' do
          opponent_team = create(:team, flag_holder_id: player.id, flag_found: true)
          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(true)
          expect(team.points).to equal(0)
          expect(opponent_team.flag_found?).to equal(true)
          expect(opponent_team.flag_held?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [])

          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(false)
          expect(team.points).to equal(POINTS_FOR_FLAG_CAPTURE)
          opponent_team.reload
          expect(opponent_team.flag_found?).to equal(false)
          expect(opponent_team.flag_held?).to equal(false)
        end
      end
    end

    context 'when a player moves onto an opponent' do
      context 'with a peg' do
        it 'removes the peg and awards the players team points' do
          opponent = create(:player, :con_peg, team: opponent_team)

          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(true)
          expect(team.points).to equal(0)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(false)
          expect(team.points).to equal(POINTS_FOR_PEG_CAPTURE)
        end
      end

      context 'without a peg' do
        it 'is a no-op' do
          opponent = create(:player, :sans_peg, team: opponent_team)

          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(false)
          expect(team.points).to equal(0)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(false)
          expect(team.points).to equal(0)
        end
      end

      context 'with the flag' do
        it 'removes the flag, peg and awards points' do
          opponent = create(:player, :con_peg, team: opponent_team)
          team.take_flag!(opponent)

          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(false)
          expect(team.points).to equal(0)
          expect(team.flag_found?).to equal(true) # denotes if the opponenets can see the flag
          expect(team.flag_held?).to equal(true)
          expect(opponent.has_peg?).to equal(true)
          expect(opponent.has_flag?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(false)
          expect(team.points).to equal(POINTS_FOR_FLAG_RETURN + POINTS_FOR_PEG_CAPTURE)
          expect(team.flag_found?).to equal(true)
          expect(team.flag_held?).to equal(false)
          expect(opponent.has_peg?).to equal(false)
          expect(opponent.has_flag?).to equal(false)
        end
      end
    end
  end
end