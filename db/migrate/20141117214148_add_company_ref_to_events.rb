class AddCompanyRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :company, index: true
  end
end
