class CreateLogCounts < ActiveRecord::Migration
  def change
    create_table :log_counts do |t|

      t.timestamps null: false
    end
  end
end
