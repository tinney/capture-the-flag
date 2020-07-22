class AddAbilityToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :ability, :integer, default: 0
  end
end
