class CreateTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name, null: false, default: "", index: true
      t.uuid :leader_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
