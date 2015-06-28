class AddTimeZoneToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :time_zone, :string, default: "", null: false
  end
end
