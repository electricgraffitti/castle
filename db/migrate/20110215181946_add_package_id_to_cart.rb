class AddPackageIdToCart < ActiveRecord::Migration
  def self.up
    add_column :carts, :package_id, :integer
    add_index  :carts, :package_id
  end

  def self.down
    remove_column :carts, :package_id
  end
end
