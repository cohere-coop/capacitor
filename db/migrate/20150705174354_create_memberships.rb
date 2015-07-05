class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.uuid :team_id, null: false, index: true
      t.uuid :account_id, null: false, index: true
    end
  end
end
