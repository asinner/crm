class AddTimelineRefToTimelineEvents < ActiveRecord::Migration
  def change
    add_reference :timeline_events, :timeline, index: true
  end
end
