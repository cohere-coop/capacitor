class AddNotesToCapacity < ActiveRecord::Migration[4.2]
  def change
    add_column :logs, :notes, :text
  end
end
