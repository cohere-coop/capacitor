class RemoveProjectRemaingCapacity < ActiveRecord::Migration
  def change
    remove_column :projects, :capacity_logged, :integer, default: 0, null: false
  end
end
