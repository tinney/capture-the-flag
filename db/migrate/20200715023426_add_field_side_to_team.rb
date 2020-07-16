class AddFieldSideToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :field_side, :integer, default: 0
  end
end
