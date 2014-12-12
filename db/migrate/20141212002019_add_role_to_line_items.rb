class AddRoleToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :role, :string
  end
end
