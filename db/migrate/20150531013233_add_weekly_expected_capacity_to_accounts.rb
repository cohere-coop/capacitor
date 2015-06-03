class AddWeeklyExpectedCapacityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :weekly_expected_capacity, :integer, defalut: 0, null: false
  end
end
