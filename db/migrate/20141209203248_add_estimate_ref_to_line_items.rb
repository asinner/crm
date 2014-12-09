class AddEstimateRefToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :estimate, index: true
  end
end
