require 'rails_helper'

RSpec.describe 'GameColliderHandler' do
  let(:team) { create(:team) }
  let(:opponent_team) { create(:team) }
  let(:player) { create(:player, :con_peg, team: team) }
  let(:opponent) { create(:player, :con_peg, team: opponent_team) }


  describe '#handle_in_opponent_base_collisions' do 
    context 'when a player moves to an empty square' do
      it 'is a no-op' do
        opponent_team
        GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [], on_flag: false)

        expect(player.has_peg?).to equal(true)
        expect(player.has_flag?).to equal(false)
        expect(team.points).to equal(0)
        expect(opponent_team.points).to equal(0)
      end
    end

    context 'w/ a peg' do
      let(:player) { create(:player, :con_peg, team: team) }
      
      context 'a player moves onto an opponent' do
        it 'removes the players peg' do
          expect(player.has_peg?).to equal(true)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: false)
          expect(player.has_peg?).to equal(false)
        end

        it 'does not remove the opponents peg' do
          expect(opponent.has_peg?).to equal(true)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: false)
          expect(opponent.has_peg?).to equal(true)
        end

        it 'awards the opponents teams points for the capture' do
          opponent_team = create(:team, opponent_with_flag: player)
          expect(opponent_team.points).to equal(0)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: false)
          expect(opponent_team.reload.points).to eq(POINTS_FOR_PEG_CAPTURE)
        end
      end

      context 'when a player moves onto the opponents flag' do
        it 'picks up the flag' do
          expect(opponent_team.flag_found?).to equal(false)
          expect(opponent_team.flag_held?).to equal(false)
          expect(player.has_flag?).to equal(false)

          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], on_flag: true)
          opponent_team.reload

          expect(player.has_flag?).to equal(true)
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
          expect(team.points).to equal(0)
        end
      end
    end
  end

  describe '#handle_in_team_base_collisions' do
    context 'when a player moves to an empty square' do
      it 'is a no-op' do
        opponent_team
        GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [])

        expect(player.has_peg?).to equal(true)
        expect(player.has_flag?).to equal(false)
        expect(team.points).to equal(0)
      end

      context 'when the player has the flag' do
        it 'awards the points and resets the opponents flag' do
          opponent_team = create(:team, opponent_with_flag: player)
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
          expect(team.reload.points).to equal(POINTS_FOR_PEG_CAPTURE)
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
        let(:opponent) { create(:player, :con_peg, name: 'Charlie', team: opponent_team) }
        let(:team) { create(:team, name: 'Yellow Team', opponent_with_flag: opponent) }

        it 'removes the flag, peg and awards points' do
          expect(team.points).to equal(0)
          expect(team.flag_found?).to equal(true) # denotes if the opponenets can see the flag
          expect(team.flag_held?).to equal(true)
          expect(opponent.has_peg?).to equal(true)
          expect(opponent.has_flag?).to equal(true)
          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(false)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.has_peg?).to eq(true)
          expect(player.has_flag?).to eq(false)
          expect(team.reload.points).to eq(POINTS_FOR_FLAG_RETURN + POINTS_FOR_PEG_CAPTURE)
          expect(team.flag_found?).to eq(true)
          expect(team.flag_held?).to eq(false)
          expect(opponent.has_peg?).to eq(false)
          expect(opponent.has_flag?).to eq(false)
        end
      end
    end
  end
end