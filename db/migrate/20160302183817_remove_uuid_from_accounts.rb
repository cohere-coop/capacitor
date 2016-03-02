class RemoveUuidFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :uuid
  end
end
