require "rails_helper"

RSpec.feature "Moves API", type: :request do
  let(:headers) do
    {
      "ACCEPT" => "application/json",     # This is what Rails 4 accepts
      "HTTP_ACCEPT" => "application/json", # This is what Rails 3 accepts
      "PLAYER" => player_id,
      "PLAYER_NAME" => player_name 
    }
  end
  
  let(:opponent_team) { create(:team)}
  let(:team) { create(:team, field_side: :right_field) }
  let(:x_location) { 5 }
  let(:y_location) { 8 }
  let(:player) { create(:player, :con_peg, team: team, x_location: x_location, y_location: y_location) }
  let(:player_id) { player.id }
  let(:player_name) { player.name }

  context "Without a player id" do
    let(:player_id) { nil }
    
    scenario "Raises an error without a player" do
      post "/api/moves/", params: { direction: 'South' }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to eq("No Player ID passed in request header")
    end
  end

  context "Without a active player" do
    let(:player) { create(:player, active: false) }

    scenario "Raises an error without an active player" do
      post "/api/moves/", params: { direction: 'South' }, headers: headers

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to be_truthy
      expect(parsed_response['error']).to match(/You do not have an active player./)
    end
  end

  scenario "A Player can move across the board" do
    opponent = create(:player, team: opponent_team)

    old_x = player.x
    old_y = player.y
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    player.reload

    expect(old_x).to equal(player.x)
    expect(old_y).to be < player.y
  end
  
  scenario "A player's data is returned" do
    opponent_team = create(:team)

    post "/api/moves/", params: { direction: 'South' }, headers: headers

    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['x']).to eq(x_location)
    expect(player_params['y']).to eq(y_location + 1)
    expect(player_params['active']).to be_truthy
    expect(player_params['has_peg']).to be_truthy
    expect(player_params['has_flag']).to be_falsy
  end

  scenario 'Opponents flag location is hidden when flag is not found' do
    opponent_team = create(:team, flag_found: false)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['opponent_team']).to eq("flag_held"=>false)
  end

  scenario 'Opponents flag held is returned' do
    opponent_team = create(:team, flag_x_location: 1, flag_y_location: 2, flag_holder_id: 4, flag_found: true)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['opponent_team']).to eq("flag_x_location"=>1, "flag_y_location"=>2, "flag_held"=>true)
  end

  scenario 'Opponents flag location is returned when the flag is uncovered but not held' do
    opponent_team = create(:team, flag_x_location: 1, flag_y_location: 2, flag_holder_id: nil, flag_found: true)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['opponent_team']).to eq("flag_x_location"=>1, "flag_y_location"=>2, "flag_held"=>false)
  end

  scenario 'Player can capture the flag' do
    opponent_team = create(:team, flag_x_location: x_location, flag_y_location: y_location + 1, field_side: :left_field)
    post "/api/moves/", params: { direction: 'South' }, headers: headers

    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['has_flag']).to be_truthy
  end

  scenario "Active and opponents near player are returned" do
    opponent_team = create(:team, flag_x_location: x_location, flag_y_location: y_location + 1)
    another_player = create(:player, :active, x_location: x_location + 1, y_location: y_location + 1, team: opponent_team)
    inactive_player = create(:player, :inactive, x_location: x_location + 1, y_location: y_location + 1, team: opponent_team)

    out_of_range = DEFAULT_SIGHT_AREA + 1
    another_player = create(:player, :active, x_location: x_location + out_of_range, y_location: y_location + 1, team: opponent_team)
    
    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['opponents'].size).to equal(1)
  end
end