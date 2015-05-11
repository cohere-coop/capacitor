class AddCapacityUsedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :capacity_used, :integer, default: 0
  end
end
