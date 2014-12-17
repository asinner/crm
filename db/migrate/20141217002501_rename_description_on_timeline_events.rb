class RenameDescriptionOnTimelineEvents < ActiveRecord::Migration
  def change
    rename_column :timeline_events, :description, :body
  end
end
