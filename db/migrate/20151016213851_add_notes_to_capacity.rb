class AddNotesToCapacity < ActiveRecord::Migration
  def change
    add_column :logs, :notes, :text
  end
end
