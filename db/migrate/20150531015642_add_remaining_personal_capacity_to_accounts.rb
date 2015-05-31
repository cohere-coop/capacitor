class AddRemainingPersonalCapacityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :remaining_personal_capacity, :integer
  end
end
