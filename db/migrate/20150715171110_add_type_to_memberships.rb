class AddTypeToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :level, :string, default: "member", null: false, index: true
  end
end
