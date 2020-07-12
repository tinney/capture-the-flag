require "rails_helper"

RSpec.feature "Creating a Player API", type: :request do
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
      player_params = {
        name: "My Player",
        food_stat: 4,
        water_stat: 3,
        stamina_stat: 2,
        strength_stat: 1,
      }

      post "/api/players/", params: { player: player_params }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Team ID passed in request header")
    end
  end

  context "With a missing team id" do
    let(:team_id) { 99 }
    
    scenario "Raises an error without a team" do
      player_params = {
        name: "My Player",
        food_stat: 4,
        water_stat: 3,
        stamina_stat: 2,
        strength_stat: 1,
      }

      post "/api/players/", params: { player: player_params }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("Team not found for ID 99")
    end
  end

  scenario "A Player and a board are returned" do
    player_params = {
      name: "My Player",
      food_stat: 4,
      water_stat: 3,
      stamina_stat: 2,
      strength_stat: 1,
    }

    post "/api/players/", params: { player: player_params }, headers: headers

    parsed_response = JSON.parse(response.body)
    player_response = parsed_response["player"]

    expect(player_response['active']).to be_truthy
    expect(player_response['days_active']).to be(0)
    expect(player_response['days_without_water']).to be(0)
    expect(player_response['days_without_food']).to be(0)
    expect(player_response['water_count']).to be(3)
    expect(player_response['food_count']).to be(4)

    expect(player_response['x']).to be_truthy
    expect(player_response['y']).to be_truthy
  end

  scenario "Team existing players are deactivated" do
    player_1 = create(:player, team: team)
    player_params = {
      name: "My Player",
      food_stat: 4,
      water_stat: 3,
      stamina_stat: 2,
      strength_stat: 1,
    }

    expect(player_1).to be_active

    post "/api/players/", params: { player: player_params }, headers: headers
    parsed_response = JSON.parse(response.body)

    player_1.reload

    expect(player_1).not_to be_active
    expect(parsed_response['player']['active']).to be_truthy
  end
  
  scenario "returns an error message for bad stats" do
    player_params = {
      name: "My Player",
      food_stat: 0,
      water_stat: 11,
      stamina_stat: 6,
      strength_stat: -3,
    }

    post "/api/players/", params: { player: player_params }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['error']).to eq("food_stat must be between 1 and 10., water_stat must be between 1 and 10., stamina_stat must be between 1 and 5., strength must be between 1 and 10.")
  end

  scenario "get a player - when not a team player" do
    get "/api/player/", params: {}, headers: headers

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['error']).to eq("no active player for team: Todd & Justin #{team.id}")
  end
  
  scenario "get a player - A Player and a board are returned" do
    create(:player, team: team, name: "My Player", food_stat: 4, water_stat: 3, stamina_stat: 2, strength_stat: 1)

    get "/api/player/", params: {}, headers: headers

    parsed_response = JSON.parse(response.body)
    player_response = parsed_response["player"]

    expect(player_response['active']).to be_truthy
    expect(player_response['days_active']).to be(0)
    expect(player_response['days_without_water']).to be(0)
    expect(player_response['days_without_food']).to be(0)
    expect(player_response['water_count']).to be(3)
    expect(player_response['food_count']).to be(4)

    expect(player_response['x']).to be_truthy
    expect(player_response['y']).to be_truthy
  end
end