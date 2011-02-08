class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.string :notes

      t.timestamps
    end
    add_index :cart_items, :cart_id
    add_index :cart_items, :product_id
  end

  def self.down
    drop_table :cart_items
  end
end
