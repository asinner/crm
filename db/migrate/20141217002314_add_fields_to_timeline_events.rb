class AddFieldsToTimelineEvents < ActiveRecord::Migration
  def change
    add_column :timeline_events, :start_time, :datetime
    add_column :timeline_events, :end_time, :datetime
  end
end
