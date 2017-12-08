class RenameProjectToActivity < ActiveRecord::Migration[4.2]
  def change
    rename_table :projects, :activities
    rename_column :logs, :project_id, :activity_id
    rename_table :teams_projects, :teams_activities
    rename_column :teams_activities, :project_id, :activity_id
  end
end
