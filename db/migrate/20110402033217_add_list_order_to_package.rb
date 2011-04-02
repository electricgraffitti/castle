class AddListOrderToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :list_order, :integer
  end

  def self.down
    remove_column :packages, :list_order
  end
end
