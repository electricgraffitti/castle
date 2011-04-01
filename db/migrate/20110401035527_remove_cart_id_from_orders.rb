class RemoveCartIdFromOrders < ActiveRecord::Migration
  def self.up
    remove_column :orders, :cart_id
    add_column :orders, :complete, :boolean
  end

  def self.down
    remove_column :orders, :complete
    add_column :orders, :cart_id, :boolean
  end
end
