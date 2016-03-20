class AddWorkedAtToCheckIn < ActiveRecord::Migration
  def change
    add_column :check_ins, :worked_at, :string
  end
end
