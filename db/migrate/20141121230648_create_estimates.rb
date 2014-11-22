class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.references :event, index: true

      t.timestamps
    end
  end
end
