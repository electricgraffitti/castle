class AddIndexesToPhoto < ActiveRecord::Migration
  def self.up
    add_index :photos, :blog_id
    add_index :photos, :product_id
    add_index :photos, :package_id
  end

  def self.down
  end
end
