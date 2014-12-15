class AddEventReferenceToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :event, index: true
  end
end
