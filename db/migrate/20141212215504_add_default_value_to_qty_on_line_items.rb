class AddDefaultValueToQtyOnLineItems < ActiveRecord::Migration
  def change
    change_column_default :line_items, :qty, 0
  end
end
