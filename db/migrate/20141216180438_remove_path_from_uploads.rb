class RemovePathFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :path
  end
end
