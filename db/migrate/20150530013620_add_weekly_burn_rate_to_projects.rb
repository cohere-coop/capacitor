class AddWeeklyBurnRateToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :weekly_burn_rate, :integer
  end
end
