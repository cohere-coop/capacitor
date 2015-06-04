class AddDefaultValueToWeeklyExpectedCapacityToAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :weekly_expected_capacity, :integer, default: 0, null: false
  end
end
