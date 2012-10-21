class AddFinalizedToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :finalized, :boolean, default: 0
  end
end
