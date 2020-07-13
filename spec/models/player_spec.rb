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
#

RSpec.describe 'Player' do
  context 'validations' do
    it 'limits the total stats to 20' do
      subject = build(:player, water_stat: 30)
      expect(subject).to_not be_valid
    end

    it 'requires defaults stats' do
      subject = build(:player, water_stat: nil)
      expect(subject).not_to be_valid
    end

    it 'creates a move when started' do
      subject = create(:player)
      expect(subject.moves.size).to equal(1)
    end
  end
end
