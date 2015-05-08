class AddDoNotBillToCapacities < ActiveRecord::Migration
  def change
    add_column :capacities, :do_not_bill, :boolean
  end
end
