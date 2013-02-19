class AddRestricedAwareToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :restricted_aware, :boolean
  end
end
