class CreatePackagedProducts < ActiveRecord::Migration
  def self.up
    create_table :packaged_products do |t|
      t.integer :package_id
      t.integer :product_id
      t.integer :included_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :packaged_products
  end
end
