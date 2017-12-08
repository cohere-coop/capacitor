class RemoveUsernameFromAccounts < ActiveRecord::Migration[4.2]
  def change
    remove_column :accounts, :username
  end
end
