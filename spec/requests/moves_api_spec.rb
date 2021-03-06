require "rails_helper"

RSpec.feature "Moves API", type: :request do
  let(:player) { create(:player, :con_peg, team: team, x_location: x_location, y_location: y_location) }
  let(:headers) do
    {
      accept: 'application/json',
      authorization: with_token_authorization(player.email)
    }
  end

  let(:opponent_team) { create(:team)}
  let(:team) { create(:team, field_side: :right_field) }
  let(:x_location) { 5 }
  let(:y_location) { 8 }

  context 'A player on a left field boundary' do
    let(:team) { create(:team, field_side: :left_field) }
    let(:opponent_team) { create(:team, field_side: :right_field)}
    let(:x_location) { FLAG_DIVIDER }
    let(:y_location) { 8 }
    let(:player) { create(:player, :con_peg, team: team, x_location: x_location, y_location: y_location) }

    scenario "cannot move into their flag area" do
      opponent_team
      current_x = player.x

      post "/api/moves/", params: { direction: 'West' }, headers: headers
      parsed_response = JSON.parse(response.body)

      expect(player.reload.x).to equal(current_x)
      expect(player.y).to equal(y_location)
    end
  end

  context 'A player on a right field boundary' do
    let(:team) { create(:team, field_side: :right_field) }
    let(:opponent_team) { create(:team, field_side: :left_field)}
    let(:x_location) { BOARD_WIDTH - FLAG_DIVIDER }
    let(:y_location) { 8 }
    let(:player) { create(:player, :con_peg, team: team, x_location: x_location, y_location: y_location) }

    scenario "cannot move into their flag area" do
      opponent_team
      current_x = player.x

      post "/api/moves/", params: { direction: 'East' }, headers: headers
      parsed_response = JSON.parse(response.body)

      expect(player.reload.x).to equal(current_x)
      expect(player.y).to equal(y_location)
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
    expect(player_params['has_peg']).to be_truthy
    expect(player_params['has_flag']).to be_falsy
  end

  scenario 'Opponents flag location is hidden when flag is not found' do
    opponent_team = create(:team)
    create(:flag, team: opponent_team, revealed: false)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['flag']).to eq({ 'held' => false, 'revealed' => false, 'x' => nil, 'y' => nil})
  end

  scenario 'Opponents flag held is in the response when the flag is revealed' do
    create(:flag, x_location: 1, y_location: 2, revealed: true, player_id: 4)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['flag']).to eq("x"=>1, "y"=>2, "held"=>true, 'revealed' => true)
  end

  scenario 'Opponents flag location is returned when the flag is uncovered but not held' do
    opponent_team = create(:team)
    create(:flag, team: opponent_team, x_location: 1, y_location: 2, player_id: nil, revealed: true)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['flag']).to eq("x"=>1, "y"=>2, "held"=>false, 'revealed' => true)
  end

  scenario 'Player can pickup the flag' do
    next_player_y_location = y_location + 1
    opponent_team = create(:team, field_side: :left_field)
    create(:flag, team: opponent_team, x_location: x_location, y_location: next_player_y_location)

    post "/api/moves/", params: { direction: 'South' }, headers: headers

    parsed_response = JSON.parse(response.body)
    player_params = parsed_response['player']

    expect(player_params['has_flag']).to be_truthy
  end

  scenario "Active and opponents near player are returned" do
    out_of_range = SIGHT_RANGE + 1

    opponent_team = create(:team)
    flag = create(:flag, team: opponent_team, x_location: x_location, y_location: y_location + 1)

    another_player = create(:player, :active, x_location: x_location + 2, y_location: y_location + 1, team: team)
    another_player = create(:player, :active, x_location: x_location + 1, y_location: y_location + 1, team: opponent_team)
    inactive_player = create(:player, :inactive, x_location: x_location + 1, y_location: y_location + 1, team: opponent_team)

    another_player = create(:player, :active, x_location: x_location + out_of_range, y_location: y_location + 1, team: opponent_team)

    post "/api/moves/", params: { direction: 'South' }, headers: headers
    parsed_response = JSON.parse(response.body)

    expect(parsed_response['opponents'].size).to equal(1)
  end
end
