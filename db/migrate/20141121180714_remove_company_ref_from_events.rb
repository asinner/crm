class RemoveCompanyRefFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :company_id
  end
end
