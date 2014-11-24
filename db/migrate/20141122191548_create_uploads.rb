class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :url
      t.integer :size, limit: 8
      t.string :name
      t.string :mime_type
      t.references :event, index: true

      t.timestamps
    end
  end
end
