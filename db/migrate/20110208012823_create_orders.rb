class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cart_id

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :cart_id
  end

  def self.down
    drop_table :orders
  end
end
