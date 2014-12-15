class ChangeReferencesOnNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :lead_id
  end
end
