# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  team_id    :integer
#  name       :string
#  active     :boolean          default(TRUE), not null
#  x_location :integer          not null
#  y_location :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  has_peg    :boolean          default(FALSE)
#  icon       :string           default("💚")
#

require 'rails_helper'

RSpec.describe 'Player' do
  it 'creates a move when started' do
    player = create(:player)
    expect(player.moves.size).to equal(1)
  end
end