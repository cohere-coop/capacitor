class RemoveUsernameFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :username
  end
end
