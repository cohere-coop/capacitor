class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.references :account, null: false

      t.timestamps null: false
    end
    change_table :logs do |t|
      t.references :check_in
    end
  end
end
