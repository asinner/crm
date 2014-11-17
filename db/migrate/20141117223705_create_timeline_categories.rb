class CreateTimelineCategories < ActiveRecord::Migration
  def change
    create_table :timeline_categories do |t|
      t.string :name
      t.references :timeline, index: true

      t.timestamps
    end
  end
end
