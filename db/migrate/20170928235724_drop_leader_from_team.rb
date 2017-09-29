class DropLeaderFromTeam < ActiveRecord::Migration[5.1]
  def change
    remove_column :teams, :leader_id, :uuid
  end
end
