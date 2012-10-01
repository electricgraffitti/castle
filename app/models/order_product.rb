# == Schema Information
#
# Table name: order_products
#
#  id               :integer(4)      not null, primary key
#  order_id         :integer(4)
#  product_id       :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  product_location :string(255)
#

class OrderProduct < ActiveRecord::Base
  
  belongs_to :order
  belongs_to :product
  
  # Scopes
  scope :empty_order_products, where(:product_id => nil)
  
  # Methods

  def self.create_order_products(params, order)
    params[:order_product].each do |order_product|
      op = OrderProduct.create(product_id: order_product[1]['product_id'], order_id: order.id)
    end
  end
  
  def self.delete_empty_records
    eop = self.empty_order_products
    unless eop.empty?
      eop.each do |ep|
        ep.delete
      end
    end
    
  end
  
  
end
