class CreateTimelineEvents < ActiveRecord::Migration
  def change
    create_table :timeline_events do |t|
      t.references :timeline_category, index: true
      t.string :description

      t.timestamps
    end
  end
end
