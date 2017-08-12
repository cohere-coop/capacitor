class RemoveNullConstraintOnAccountPassword < ActiveRecord::Migration
  def change
    change_column :accounts, :encrypted_password, :string,  null: true
  end
end
