class AddPackageIdToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :package_id, :integer
  end

  def self.down
    remove_column :photos, :package_id
  end
end
