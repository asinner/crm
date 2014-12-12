class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.references :product, index: true
      t.string :name
      t.string :description
      t.integer :amount
      t.integer :qty
      t.boolean :automatic

      t.timestamps
    end
  end
end
