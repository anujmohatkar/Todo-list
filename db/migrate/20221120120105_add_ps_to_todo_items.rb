class AddPsToTodoItems < ActiveRecord::Migration[6.1]
  def change
    add_column :todo_items, :ps, :decimal, precision: 10, scale: 3
  end
end
