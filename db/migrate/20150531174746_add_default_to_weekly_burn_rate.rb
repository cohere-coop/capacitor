class AddDefaultToWeeklyBurnRate < ActiveRecord::Migration[4.2]
  def change
    change_column :projects, :weekly_burn_rate, :integer, default: 0, null: false
  end
end
