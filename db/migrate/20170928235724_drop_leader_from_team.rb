class DropLeaderFromTeam < ActiveRecord::Migration[5.1]
  def change
    remove_column :teams, :leader_id, :uuid, null: false
  end
end
