class AddTermsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :terms, :boolean
  end
end
