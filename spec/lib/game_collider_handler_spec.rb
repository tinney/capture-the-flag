require 'rails_helper'

RSpec.describe 'GameColliderHandler' do
  describe '#handle_collisions' do
    let(:starting_resource_count) { 0 }
    let(:water_stat) { 5 }
    let(:food_stat) { 5 }
    let(:strength_stat) { 5 }
    let(:days_active) { 100 }

    let(:player) { create(:player, food_count: starting_resource_count, water_count: starting_resource_count, strength_stat: strength_stat, food_stat: food_stat, water_stat: water_stat, stamina_stat: 1, days_active: days_active ) }
    
    context 'when there is no resources for the location' do
      let(:resources) { [] }

      it 'does nothing' do
        GameColliderHandler.handle_collisions(player, resources)
        expect(player.food_count).to equal(starting_resource_count)
        expect(player.water_count).to equal(0)
      end
    end
    
    context 'when the resource is an an opponent' do
      let(:food_count) { 10 }
      let(:opponent) { create(:player, strength_stat: 2, food_stat: 10, food_count: food_count) }
      let(:resources) { [opponent] }

      context "when the player has less strength" do
        let(:strength_stat) { 1 }
      end

      context "when the player has more strength" do
        let(:strength_stat) { 5 }
        
        context "when the opponent has food" do
          let(:food_count) { 10 }

          it 'fills up the players food removing it from the opponent' do
            GameColliderHandler.handle_collisions(player, resources)
            opponent.reload
            player.reload
            
            expect(opponent.food_count).to equal(food_count - food_stat)
            expect(player.food_count).to equal(food_stat)
            expect(player.water_count).to equal(starting_resource_count)
          end
          
          context 'when the player only needs a little food' do
            let(:starting_resource_count) { 4 }
            
            it 'only takes as much food as the player needs' do
              GameColliderHandler.handle_collisions(player, resources)
              opponent.reload
              player.reload
              
              expect(opponent.food_count).to equal(food_count - 1)
              expect(player.food_count).to equal(food_stat)
              expect(player.water_count).to equal(starting_resource_count)
            end
          end
          

          context "when the opponent has a little food" do
            let(:food_count) { 3 }

            it 'takes as much of the opponents food as it can' do
              GameColliderHandler.handle_collisions(player, resources)

              opponent.reload
              player.reload
              
              expect(opponent.food_count).to equal(0)
              expect(player.food_count).to equal(food_count)
              expect(player.water_count).to equal(starting_resource_count)
            end
          end
        end

        context "when the opponent has no food" do
          let(:food_count) { 0 }
          
          it 'is a no op' do
            GameColliderHandler.handle_collisions(player, resources)
            expect(opponent.food_count).to equal(starting_resource_count)
            expect(player.food_count).to equal(starting_resource_count)
            expect(player.water_count).to equal(starting_resource_count)
          end
        end
      end
    end
    
    context 'when the resource is water' do
      let(:resources) { [create(:resource, is_water: true, amount: 100)] }

      it 'fills the players water' do
        GameColliderHandler.handle_collisions(player, resources)
        expect(player.food_count).to equal(0)
        expect(player.water_count).to equal(water_stat)
      end
    end

    context 'when the resource is food' do
      let(:resources) { [resource] }

      context "when there is not enough food to fill the player container" do
        let(:food_amount) { 3 }
        let(:resource) { create(:resource, is_food: true, is_water: false, amount: food_amount, active: true) }

        it 'takes all the food and and deactivates the food' do
          player = create(:player, water_count: 0, food_count: 0, food_stat: 5)
          GameColliderHandler.handle_collisions(player, resources)

          resource.reload

          expect(player.food_count).to equal(food_amount)
          expect(player.water_count).to equal(0)

          expect(resource.amount).to equal(0)
          expect(resource.active).to equal(false)
        end
      end

      context "when there is enough food to fill the player container" do
        let(:food_amount) { 10 }
        let(:resource) { create(:resource, is_food: true, is_water: false, amount: food_amount, active: true) }

        it 'fills the players food and leaves the food active decrementing the food amount' do
          player = create(:player, water_count: 0, food_count: 0, food_stat: 5)
          GameColliderHandler.handle_collisions(player, resources)

          resource.reload

          expect(player.food_count).to equal(food_stat)
          expect(player.water_count).to equal(0)

          expect(resource.amount).to equal(food_amount - food_stat)
          expect(resource.active).to equal(true)
        end
      end
    end
  end
end