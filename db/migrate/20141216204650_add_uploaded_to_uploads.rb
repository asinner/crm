class AddUploadedToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :uploaded, :boolean
  end
end
