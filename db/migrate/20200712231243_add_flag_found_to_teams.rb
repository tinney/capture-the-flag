class AddFlagFoundToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :flag_found, :boolean, default: false
  end
end
