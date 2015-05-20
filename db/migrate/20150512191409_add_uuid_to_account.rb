class AddUuidToAccount < ActiveRecord::Migration
  def change
    enable_extension "uuid-ossp"
    add_column :accounts, :uuid, :uuid, default: "uuid_generate_v4()", null: false
  end
end
