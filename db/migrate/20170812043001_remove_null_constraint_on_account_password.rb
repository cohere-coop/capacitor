class RemoveNullConstraintOnAccountPassword < ActiveRecord::Migration[4.2]
  def up
    change_column :accounts, :encrypted_password, :string,  null: true
  end

  def down
    change_column :accounts, :encrypted_password, :string,  null: false
  end
end
