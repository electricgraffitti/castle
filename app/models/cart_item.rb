# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  package_id :integer
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
    @combo_id = product_ref.combo_id
    @combo_item = product_ref.combo_item
    
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
  
  def combo_id
    @combo_id
  end
  
  def combo_item
    @combo_item
  end
  
  def interactive
    @interactive
  end
  
  def requires_location
    @requires_location
  end
end
