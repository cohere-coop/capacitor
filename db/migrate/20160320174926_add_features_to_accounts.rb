class AddFeaturesToAccounts < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :accounts, :features, :hstore
  end
end
