class AddContriToTodoItems < ActiveRecord::Migration[6.1]
  def change
    add_column :todo_items, :contri, :integer
  end
end
