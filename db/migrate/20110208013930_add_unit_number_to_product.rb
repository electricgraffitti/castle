class AddUnitNumberToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :unit_number, :string
  end

  def self.down
    remove_column :products, :unit_number
  end
end
