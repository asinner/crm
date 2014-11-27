class ChangeFieldsOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
    rename_column :users, :token, :authentication_token
  end
end
