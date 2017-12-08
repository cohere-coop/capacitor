class AddFeaturesToAccounts < ActiveRecord::Migration[4.2]
  def change
    enable_extension "hstore"
    add_column :accounts, :features, :hstore
  end
end
