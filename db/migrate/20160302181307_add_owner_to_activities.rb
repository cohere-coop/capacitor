class AddOwnerToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.uuid :owner_id
    end
  end
end