class AddListOrderToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :list_order, :integer
  end

  def self.down
    remove_column :products, :list_order
  end
end
