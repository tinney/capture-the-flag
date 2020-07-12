require "rails_helper"

RSpec.feature "Moves API", type: :request do
  let(:headers) do
    {
      "ACCEPT" => "application/json",     # This is what Rails 4 accepts
      "HTTP_ACCEPT" => "application/json", # This is what Rails 3 accepts
      "TEAM" => team_id 
    }
  end
  
  let(:team) { create(:team) }
  let(:team_id) { team.id }

  context "Without a team id" do
    let(:team_id) { nil }
    
    scenario "Raises an error without a team" do
      post "/api/moves/", params: { direction: 'South' }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Team ID passed in request header")
    end
  end

  context "Without a active player" do
    scenario "Raises an error without an active player" do
      post "/api/moves/", params: { direction: 'South' }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("You do not have an active player. Post to /api/players to create a new player.")
    end
  end

  scenario "A Player can move across the board" do
    player = create(:player, team: team, stamina_stat: 1)

    old_x = player.x
    old_y = player.y
    old_days_active = player.days_active
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    player.reload

    expect(old_x).to equal(player.x)
    expect(old_y).to be < player.y
    expect(old_days_active).to be < player.days_active
  end

  scenario "A Player days_without_x (food/water) are updated when they have no food or water" do
    player = create(:player, team: team, food_count: 0, water_count: 0, stamina_stat: 4)
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    player.reload

    expect(player.days_without_food).to be(1)
    expect(player.days_without_water).to be(1)
    expect(player.active).to be_truthy
  end
  
  scenario "A Player without water should no longer be active" do
    player = create(:player, team: team, days_without_water: MAX_DAYS_WITHOUT_WATER, water_count: 0)
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    player.reload

    expect(player.active).to be_falsy
  end

  scenario "A Player without food should no longer be active" do
    player = create(:player, team: team, days_without_food: MAX_DAYS_WITHOUT_FOOD, food_count: 0)
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    player.reload

    expect(player.active).to be_falsy
  end



  scenario "A Player and a board are returned" do
    player = create(
      :player,
      team: team,
      x_location: 20,
      y_location: 10,
      food_stat: 4, 
      water_stat: 5, 
      stamina_stat: 1
    )

    another_player = create(:player, :active, x_location: 20, y_location: 50)
    inactive_player = create(:player, :inactive, x_location: 20, y_location: 50)
    water_resource = create(:resource, :active, :water, x_location: 22, y_location: 11)
    food_resource = create(:resource, :active, :food, x_location: 22, y_location: 11)
    inactive_resource = create(:resource, :inactive, x_location: 20, y_location: 20)
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['x']).to equal(20)
    expect(player_params['y']).to equal(11)
    expect(player_params['active']).to be_truthy
    expect(player_params['days_active']).to be(1)
    expect(player_params['days_without_water']).to be(0)
    expect(player_params['days_without_food']).to be(0)
    
    expect(player_params['water_count']).to be(4)
    expect(player_params['food_count']).to be(3)

    expect(parsed_response['board'].size).to equal(3)
  end



  scenario "Update days without food/water and food/water counts when finding a resource" do
    food_amount = 2 
    water_stat = 5
    food_stat = 1

    player = create(
      :player,
      team: team,
      food_count: 0,
      water_count: 0,
      days_without_food: 10,
      days_without_water: 0,
      x_location: 0,
      y_location: 0,
      food_stat: food_stat,
      water_stat: water_stat, 
      stamina_stat: 1
    )

    food_resource = create(:resource, :active, :food, amount: food_amount, x_location: 1, y_location: 0)
    water_resource = create(:resource, :active, :water, x_location: 2, y_location: 0)
    
    post "/api/moves/", params: { direction: 'East' }, headers: headers
    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['x']).to equal(1)
    expect(player_params['y']).to equal(0)
    expect(player_params['active']).to be_truthy
    expect(player_params['days_active']).to be(1)
    expect(player_params['days_without_water']).to be(1)
    expect(player_params['days_without_food']).to be(0) # reset to 0 days
    expect(player_params['water_count']).to be(0)
    expect(player_params['food_count']).to be(0) # refilled but then consumed
    expect(parsed_response['board'].size).to equal(2)

    post "/api/moves/", params: { direction: 'East' }, headers: headers
    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['x']).to equal(2)
    expect(player_params['y']).to equal(0)
    expect(player_params['active']).to be_truthy
    expect(player_params['days_active']).to be(2)
    expect(player_params['days_without_water']).to be(0)
    expect(player_params['days_without_food']).to be(1) # updated to 1 day
    expect(player_params['water_count']).to be(water_stat - 1)
    expect(player_params['food_count']).to be(0)
    expect(parsed_response['board'].size).to equal(2)

    post "/api/moves/", params: { direction: 'West' }, headers: headers
    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['x']).to equal(1)
    expect(player_params['y']).to equal(0)
    expect(player_params['active']).to be_truthy
    expect(player_params['days_active']).to be(3)
    expect(player_params['days_without_water']).to be(0) 
    expect(player_params['days_without_food']).to be(0) # reset back to 0 days
    expect(player_params['water_count']).to be(water_stat - 2)
    expect(player_params['food_count']).to be(0) # found food but then ate it
    expect(parsed_response['board'].size).to equal(1)
  end
end