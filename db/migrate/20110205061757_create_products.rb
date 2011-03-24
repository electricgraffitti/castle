class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :item_name
      t.text :description
      t.boolean :alarm_system
      t.boolean :addons
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
