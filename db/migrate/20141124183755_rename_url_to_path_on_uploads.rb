class RenameUrlToPathOnUploads < ActiveRecord::Migration
  def change
    rename_column :uploads, :url, :path
  end
end
