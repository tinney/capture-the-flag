require 'rails_helper'

RSpec.describe 'GameColliderHandler' do
  let(:team) { create(:team) }
  let(:opponent_team) { create(:team) }
  let(:player) { create(:player, :con_peg, team: team, ability: :sight) }
  let(:opponent) { create(:player, :con_peg, team: opponent_team) }


  describe '#handle_in_opponent_base_collisions' do 
    context 'when a player moves to an empty square' do
      it 'is a no-op' do
        opponent_team
        GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [], flag: nil)

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
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: false)
          expect(player.has_peg?).to equal(false)
        end

        it 'does not remove the opponents peg' do
          expect(opponent.has_peg?).to equal(true)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: nil)
          expect(opponent.has_peg?).to equal(true)
        end

        it 'awards the opponents teams points for the peg capture' do
          expect(opponent.team.points).to equal(0)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: nil)
          expect(opponent.team.reload.points).to eq(POINTS_FOR_PEG_CAPTURE)
        end

        it 'awards the opponents teams points for the peg & flag return' do
          flag = create(:flag, team: opponent.team, player: player, revealed: true)
          expect(opponent.team.points).to equal(0)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: nil)
          expect(opponent.team.reload.points).to eq(POINTS_FOR_PEG_CAPTURE + POINTS_FOR_FLAG_RETURN)
        end
      end

      context 'when a player moves onto the opponents flag' do
        it 'awards pickup flag points' do
          flag = create(:flag, team: opponent.team)

          expect(team.points).to equal(0)
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: flag)
          expect(team.reload.points).to equal(POINTS_FOR_FLAG_PICKUP)
        end

        it 'picks up the flag' do
          flag = create(:flag, team: opponent.team)

          expect(flag.captured?).to equal(false)
          expect(flag.revealed?).to equal(false)
          expect(flag.player).to be_nil
          expect(player.flag).to be_nil

          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: flag)
          player.reload

          expect(flag.captured?).to equal(false)
          expect(flag.revealed?).to equal(true)
          expect(flag.player).to eq(player)
          expect(player.flag).to eq(flag)
        end
      end
    end
    
    context 'w/o a peg' do
      let(:player) { create(:player, :sans_peg, team: team) }
      
      context 'when a player moves onto a flag' do
        it 'is a no-op' do
          flag = create(:flag, team: opponent.team)

          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: flag)

          expect(player.has_peg?).to equal(false)
          expect(player.has_flag?).to equal(false)
          expect(flag.captured?).to equal(false)
          expect(flag.revealed?).to equal(false)
          expect(flag.player).to be_nil
          expect(player.flag).to be_nil
          expect(team.points).to equal(0)
          expect(opponent.team.points).to equal(0)
        end
      end

      context 'when a player moves onto an opponent' do
        it 'is a no-op' do
          GameColliderHandler.handle_in_opponent_base_collisions(player: player, opponents: [opponent], flag: nil)

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
          flag = create(:flag, player: player,revealed: true)
          opponent_team = flag.team
          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(true)
          expect(team.points).to equal(0)
          expect(flag.revealed?).to equal(true)
          expect(flag.held?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [])

          player.reload
          team.reload
          opponent_team.reload

          expect(player.has_peg?).to equal(true)
          expect(player.has_flag?).to equal(false)
          expect(team.points).to equal(POINTS_FOR_FLAG_CAPTURE)
          expect(opponent_team.flag.revealed?).to equal(false)
          expect(opponent_team.flag.held?).to equal(false)
        end
      end
    end

    context 'when a player moves onto an opponent' do
      context 'with a peg' do
        let(:opponent) { create(:player, :con_peg, team: opponent_team) }

        it 'removes the peg' do
          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.has_peg?).to equal(true)
          expect(opponent.has_peg?).to equal(false)
        end

        it 'awards the players team points' do
          expect(team.points).to equal(0)
          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])
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
        let!(:flag) { create(:flag, team: team, player: opponent, revealed: true)}

        it 'awards points for the peg&flag capture' do
          expect(team.points).to equal(0)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(team.reload.points).to eq(POINTS_FOR_FLAG_RETURN + POINTS_FOR_PEG_CAPTURE)
        end

        it 'replaces the flag' do
          expect(flag.revealed?).to equal(true) # denotes if the opponenets can see the flag
          expect(flag.held?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(flag.reload.revealed?).to eq(true)
          expect(flag.held?).to eq(false)
        end

        it 'removes the flag from the opponents' do
          expect(opponent.has_flag?).to equal(true)
          
          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])
          flag.reload

          expect(opponent.reload.has_flag?).to eq(false)
        end

        it 'removes the opponents peg' do
          expect(opponent.has_peg?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(opponent.reload.has_peg?).to eq(false)
        end

        it 'does nothing to the players peg' do
          expect(player.has_peg?).to equal(true)

          GameColliderHandler.handle_in_team_base_collisions(player: player, opponents: [opponent])

          expect(player.reload.has_peg?).to eq(true)
        end
      end
    end
  end
end