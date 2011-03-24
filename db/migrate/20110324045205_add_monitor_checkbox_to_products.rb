class AddMonitorCheckboxToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :monitoring_addon, :boolean
  end

  def self.down
    remove_column :products, :monitoring_addon
  end
end
