class AddLeadRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :lead, index: true
  end
end
