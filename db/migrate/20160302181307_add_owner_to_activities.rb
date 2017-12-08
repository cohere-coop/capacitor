class AddOwnerToActivities < ActiveRecord::Migration[4.2]
  def change
    change_table :activities do |t|
      t.uuid :owner_id
    end
  end
end