class DestroyAndRecreateCheckInsTableWithUuids < ActiveRecord::Migration[4.2]
  def change
    drop_table :check_ins
    create_table :check_ins, id: :uuid  do |t|
      t.references :account, null: false, type: :uuid
      t.date :worked_at
      t.timestamps null: false
    end
    remove_column :logs, :check_in_id
    change_table :logs do |t|
      t.references :check_in, type: :uuid
    end
  end
end
