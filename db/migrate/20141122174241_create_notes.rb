class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :body
      t.references :lead, index: true

      t.timestamps
    end
  end
end
