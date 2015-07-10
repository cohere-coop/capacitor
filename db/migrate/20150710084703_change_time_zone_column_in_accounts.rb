class ChangeTimeZoneColumnInAccounts < ActiveRecord::Migration
  def change
     change_column :accounts, :time_zone, :string,  :limit => 255, :default => "UTC", null: false
  end
end
