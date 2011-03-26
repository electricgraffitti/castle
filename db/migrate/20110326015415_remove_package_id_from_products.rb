class RemovePackageIdFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :package_id
  end

  def self.down
    add_column :products, :package_id, :integer
  end
end
