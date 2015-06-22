class AddProjectToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :project_id, :uuid, null: false, index: true
  end
end
