require "rails_helper"

RSpec.feature "Auth API", type: :request do
  scenario "valid player access" do
    opponent_team = create(:team)
    player = create(:player)
    headers = {
      accept: 'application/json',
      authorization: with_token_authorization(player.email)
    }

    get "/api/player", headers: headers

    expect(response).to have_http_status(:ok)
  end

  scenario "no authorization" do
    get "/api/player", headers: { accept: 'application/json' }

    expect(response).to have_http_status(:unauthorized)
    expect(response_json.dig('error', 'code')).to eq(401)
    expect(response_json.dig('error', 'message')).to match(/invalid player/i)
  end

  scenario "unknown player access" do
    headers = {
      accept: 'application/json',
      authorization: with_token_authorization('whoops')
    }

    get "/api/player", headers: headers

    expect(response).to have_http_status(:unauthorized)
    expect(response_json.dig('error', 'code')).to eq(401)
    expect(response_json.dig('error', 'message')).to match(/invalid player/i)
  end

  scenario "inactive player access" do
    player = create(:player, :inactive)
    headers = {
      accept: 'application/json',
      authorization: with_token_authorization(player.email)
    }

    get "/api/player", headers: headers

    expect(response).to have_http_status(:forbidden)
    expect(response_json.dig('error', 'code')).to eq(403)
    expect(response_json.dig('error', 'message')).to match(/inactive player/i)
  end
end
