class ChangeDatetimeToDateForCheckIns < ActiveRecord::Migration
  def up
    change_column :check_ins, :worked_at, :date
  end

  def down
   change_column :check_ins, :worked_at, :datetime
 end
end
