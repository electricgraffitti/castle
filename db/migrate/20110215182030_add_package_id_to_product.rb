class AddPackageIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :package_id, :integer
    add_index  :products, :package_id
  end

  def self.down
    remove_column :products, :package_id
  end
end
