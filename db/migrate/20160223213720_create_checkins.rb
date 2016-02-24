class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|

      t.timestamps null: false
    end
  end
end
