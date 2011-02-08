class AddCartIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :cart_id, :integer
  end
  
  def self.down
    remove_column :products, :cart_id
  end
end
