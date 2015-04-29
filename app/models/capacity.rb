class Capacity < ActiveRecord::Migration

  def create_capacity
    create_table :capacity do |t|
      t.string :project_id
      t.string :account_id
      t.string :client
      t.string :project
      t.string :time
      t.string :url


      t.timestamps null: false
    end
  end
end

def add_capacity
  create_table do |c|


end
