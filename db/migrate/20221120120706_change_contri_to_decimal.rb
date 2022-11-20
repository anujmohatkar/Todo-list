class ChangeContriToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :todo_items, :contri, :decimal, precision: 10, scale: 3
  end
end
