class AddPackageIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :package_id, :integer
    add_index :users, :package_id
  end
end
