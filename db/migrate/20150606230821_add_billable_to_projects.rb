class AddBillableToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :billable, :boolean, default: true, null: false
  end
end
