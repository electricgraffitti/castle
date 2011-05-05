class AddProductLocationToOrderProducts < ActiveRecord::Migration
  
  def self.up
    add_column :order_products, :product_location, :string
  end

  def self.down
    remove_column :order_products, :product_location
  end
end
