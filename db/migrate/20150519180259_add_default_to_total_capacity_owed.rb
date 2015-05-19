class AddDefaultToTotalCapacityOwed < ActiveRecord::Migration
  def change
    change_column :projects, :total_capacity_owed, :integer, default: 0
  end
end
