require "rails_helper"

RSpec.feature "Player API", type: :request do
  scenario "Get a player" do
    opponent_team = create(:team)
    player = create(:player, :con_peg, ability: 'agility')
    headers = {
      accept: 'application/json',
      authorization: with_token_authorization(player.email)
    }

    get "/api/player/", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response_json.dig('player', 'has_peg')).to be_truthy
    expect(response_json.dig('player', 'has_flag')).to be_falsy
    expect(response_json.dig('player', 'x')).to be_truthy
    expect(response_json.dig('player', 'y')).to be_truthy
    expect(response_json.dig('player', 'is_in_safe_zone')).to be_truthy
    expect(response_json.dig('player', 'ability')).to eq('agility')
    expect(response_json.dig('opponents')).to eq([])
    expect(response_json.dig('flag')).to eq(nil)
  end
end
