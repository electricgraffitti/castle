class AddDependentItemToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :dependent_item, :boolean
  end

  def self.down
    remove_column :products, :dependent_item
  end
end
