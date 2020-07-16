class AddIconToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :icon, :string, default: '💚'
  end
end
