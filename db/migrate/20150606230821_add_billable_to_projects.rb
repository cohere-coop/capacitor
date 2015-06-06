class AddBillableToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :billable, :boolean, default: true, null: false
  end
end
