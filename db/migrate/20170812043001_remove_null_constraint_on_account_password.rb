class RemoveNullConstraintOnAccountPassword < ActiveRecord::Migration[4.2]
  def change
    change_column :accounts, :encrypted_password, :string,  null: true
  end
end
