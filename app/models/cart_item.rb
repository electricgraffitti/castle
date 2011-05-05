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
  
  attr_reader :cart_item, :quantity, :name, :cart_price
  
  def initialize(product_id)
    product_ref = Product.find(product_id)
    
    @cart_item = product_ref.id
    @name = product_ref.item_name
    @cart_price = product_ref.price
    @quantity = 1
    @requires_location = product_ref.requires_location
    
    if product_ref.interactive_service
      @interactive = product_ref.interactive_service
    else
      @interactive = product_ref.interactive_service
    end
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
  
  def interactive
    @interactive
  end
  
  def requires_location
    @requires_location
  end
end
