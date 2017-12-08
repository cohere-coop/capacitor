class RemoveUuidFromAccounts < ActiveRecord::Migration[4.2]
  def change
    remove_column :accounts, :uuid
  end
end
