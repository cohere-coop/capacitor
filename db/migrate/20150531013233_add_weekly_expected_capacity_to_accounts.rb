class AddWeeklyExpectedCapacityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :weekly_expected_capacity, :integer
  end
end
