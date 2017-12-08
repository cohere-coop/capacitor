class AddTypeToMemberships < ActiveRecord::Migration[4.2]
  def change
    add_column :memberships, :level, :string, default: "member", null: false, index: true
  end
end
