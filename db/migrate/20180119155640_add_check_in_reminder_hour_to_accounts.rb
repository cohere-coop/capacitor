class AddCheckInReminderHourToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :check_in_reminder_hour, :integer, default: 8
  end
end
