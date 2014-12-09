class RemoveEstimateLocationFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :estimate_location
  end
end
