class AddWeeklyBurnRateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :weekly_burn_rate, :integer
  end
end
