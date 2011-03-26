class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.integer :product_id
      t.integer :package_id

      t.timestamps
    end
     add_index  :systems, :package_id
     add_index  :systems, :product_id
  end

  def self.down
    drop_table :systems
  end
end
