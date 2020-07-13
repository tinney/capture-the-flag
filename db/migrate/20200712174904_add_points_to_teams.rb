class AddPointsToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :points, :integer, default: 0
  end
end
