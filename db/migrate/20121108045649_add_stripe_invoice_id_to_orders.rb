class AddStripeInvoiceIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :stripe_invoice_id, :string
  end
end
