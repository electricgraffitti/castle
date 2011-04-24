class AddRequiresLocationToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :requires_location, :boolean
  end

  def self.down
    remove_column :products, :requires_location
  end
end
