class AddEstimateLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :estimate_location, :string
  end
end
