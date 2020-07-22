require "rails_helper"

RSpec.feature "Creating a Player API", type: :request do
  let(:headers) do
    {
      "ACCEPT" => "application/json",     # This is what Rails 4 accepts
      "HTTP_ACCEPT" => "application/json", # This is what Rails 3 accepts
      "PLAYER_EMAIL" => player_email, 
    }
  end

  let(:player) { create(:player, :con_peg, name: 'Fin') }
  let(:player_email) { player.email }

  context "Without a PLAYER_EMAIL header" do
    let(:player_email) { nil }
    
    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Player Email passed in request header")
    end
  end

  context "With a non existing player id" do
    let(:player_email) { 'donkey@testdouble.com' }
    
    scenario "Raises an error" do
      get "/api/player/", params: { }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("Player not found for email donkey@testdouble.com.")
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