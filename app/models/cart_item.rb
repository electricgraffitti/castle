# == Schema Information
#
# Table name: cart_items
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  cart_id    :integer(4)
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  package_id :integer(4)
#

class CartItem < ActiveRecord::Base
  
  #Validations
  # validates :notes, :presence => true, :uniqueness => true
  
  #Associations
  belongs_to :cart
  belongs_to :product
  belongs_to :package
  
  attr_reader :cart_item, :quantity, :name, :cart_price
  
  def initialize(product_id)
    product_ref = Product.find(product_id)
    
    @cart_item = product_ref.id
    @name = product_ref.item_name
    @cart_price = product_ref.price
    @quantity = 1
  end
  
  def increment_quantity
    @quantity += 1
  end
  
  def decrement_quantity
    @quantity -= 1
  end
  
  def title
    @name
  end
  
  def price
    @cart_price * @quantity
  end
  
end
