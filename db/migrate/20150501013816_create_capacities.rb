class CreateCapacities < ActiveRecord::Migration
  def change
    create_table :capacities do |t|
      t.integer :amount
      t.integer :quality
      t.date :worked_at
      t.references :project, index: true
      t.references :worker, index: true

      t.timestamps null: false
    end
    add_foreign_key :capacities, :projects
    add_foreign_key :capacities, :accounts, column: :worker_id
  end
end
