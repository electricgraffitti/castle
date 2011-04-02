class CreateDependentProduct < ActiveRecord::Migration
  def self.up
    create_table :dependent_products do |t|
      t.integer :product_id
      t.integer :dependency_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dependent_products
  end
end
