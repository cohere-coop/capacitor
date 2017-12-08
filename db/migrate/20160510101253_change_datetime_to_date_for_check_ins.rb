class ChangeDatetimeToDateForCheckIns < ActiveRecord::Migration[4.2]
  def up
    change_column :check_ins, :worked_at, :date
  end

  def down
   change_column :check_ins, :worked_at, :datetime
 end
end
