class RemovePersonalCapacityFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :remaining_personal_capacity, :integer
  end
end
