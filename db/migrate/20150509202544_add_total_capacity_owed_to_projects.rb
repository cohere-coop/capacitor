class AddTotalCapacityOwedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :total_capacity_owed, :float
  end
end
