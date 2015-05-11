class AddCapacityRemainingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :capacity_remaining, :integer, default: 0
  end
end
