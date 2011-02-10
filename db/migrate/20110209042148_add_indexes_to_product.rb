class AddIndexesToProduct < ActiveRecord::Migration
  def self.up
    add_index :products, :cart_id
  end

  def self.down
  end
end
