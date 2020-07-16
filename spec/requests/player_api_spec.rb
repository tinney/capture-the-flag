require "rails_helper"

RSpec.feature "Creating a Player API", type: :request do
  let(:headers) do
    {
      "ACCEPT" => "application/json",     # This is what Rails 4 accepts
      "HTTP_ACCEPT" => "application/json", # This is what Rails 3 accepts
      "PLAYER" => player_id, 
      "PLAYER_NAME" => player_name 
    }
  end

  let(:player) { create(:player, :con_peg, name: 'Fin') }
  let(:player_id) { player.id }
  let(:player_name) { 'Fin' }

  context "Without a PLAYER_NAME header" do
    let(:player_name) { nil }
    
    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Player Name passed in request header")
    end
  end

  context "Without a PLAYER header" do
    let(:player_id) { nil }
    
    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Player ID passed in request header")
    end
  end

  context "With the wrong player name" do
    let(:player_name) { 'Jake' }

    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("Player not found for ID #{player.id} and name Jake")
    end
  end

  context "With a non existing player id" do
    let(:player_id) { -1 }
    
    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("Player not found for ID -1 and name Fin")
    end
  end
  
  scenario "get a player - A Player and a board are returned" do
    opponent_team = create(:team)

    get "/api/player/", params: {}, headers: headers

    parsed_response = JSON.parse(response.body)
    player_response = parsed_response["player"]

    expect(player_response['active']).to be_truthy
    expect(player_response['has_peg']).to be_truthy
    expect(player_response['has_flag']).to be_falsy

    expect(player_response['x']).to be_truthy
    expect(player_response['y']).to be_truthy
  end
end