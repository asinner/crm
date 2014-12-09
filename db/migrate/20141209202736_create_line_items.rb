class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.integer :qty

      t.timestamps
    end
  end
end
