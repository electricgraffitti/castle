class AddComboIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :combo_id, :integer
    add_column :products, :combo_item, :boolean
  end

  def self.down
    remove_column :products, :combo_item
    remove_column :products, :combo_id
  end
end
