class RemoveBooleansFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :addons
    remove_column :products, :alarm_system
  end

  def self.down
    add_column :products, :addons, :boolean
    add_column :products, :alarm_system, :boolean
  end
end
