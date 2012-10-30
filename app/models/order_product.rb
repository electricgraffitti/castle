# == Schema Information
#
# Table name: order_products
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  product_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#  product_location :string(255)
#  finalized        :boolean          default(FALSE)
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

  def self.get_interactive_service(params)
    params[:order_product].each do |order_product|
      if order_product[1]['product_id'] == "24" || "25"
        interactive_service_id = (order_product[1]['product_id']).to_i
      end
    end
  end

  def has_location?
    product_location.blank? ? true : false
  end

  def is_finalized?
    finalized ? true : false
  end

  def is_assigned?
    has_location? || is_finalized? ? false : true
  end

  def self.unassigned_items(order_products)
    unassigned_items = []
    order_products.each do |order_product|
      unless order_product.is_assigned?
        unassigned_items.push(order_product)
      end
    end
    unassigned_items
  end

  def self.assigend_items(order_products)
    has_locations = []
    order_products.each do |order_product|
      if order_product.has_location?
        has_locations.push(order_product)
      end
    end
    has_locations
  end

  def self.finalized_items(order_products)
    finalized_items = []
    order_products.each do |order_product|
      if order_product.is_finalized?
        finalized_items.push(order_product)
      end
    end
    finalized_items
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
