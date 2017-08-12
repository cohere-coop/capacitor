class AddSettingsToAccount < ActiveRecord::Migration
  def change
    enable_extension "citext"
    add_column :accounts, :settings, :jsonb, null: false, default: "{}"
  end
end
