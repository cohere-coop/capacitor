class AddTimeZoneToAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :accounts, :time_zone, :string, default: "Central Time (US & Canada)", null: false
  end
end
