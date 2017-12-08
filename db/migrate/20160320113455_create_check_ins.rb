class CreateCheckIns < ActiveRecord::Migration[4.2]
  def change
    create_table :check_ins do |t|
      t.references :account, null: false
      t.datetime :worked_at
      t.timestamps null: false
    end
    change_table :logs do |t|
      t.references :check_in
    end
  end
end
