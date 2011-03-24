class AddPackageIdToCartItem < ActiveRecord::Migration
  def self.up
    add_column :cart_items, :package_id, :integer
    add_index  :cart_items, :package_id
  end

  def self.down
    remove_column :cart_items, :package_id
  end
end
