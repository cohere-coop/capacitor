class CreateTeamsProjects < ActiveRecord::Migration
  def change
    create_table :teams_projects do |t|
      t.uuid :team_id, null: false, index: true
      t.uuid :project_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
