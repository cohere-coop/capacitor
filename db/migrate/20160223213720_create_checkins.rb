class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|

      t.timestamps null: false
    end
  end
end
