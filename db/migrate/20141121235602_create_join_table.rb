class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :estimates, :products do |t|
      # t.index [:estimate_id, :product_id]
      # t.index [:product_id, :estimate_id]
    end
  end
end
