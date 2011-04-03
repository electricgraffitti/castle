# == Schema Information
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  complete   :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#  package_id :integer(4)
#

class Cart # < ActiveRecord::Base
  
  #Associtations
  # belongs_to :user
  # has_many :cart_items, :dependent => :destroy
  # has_one :package, :through => :cart_items
  # has_many :products, :through => :cart_items
  
  attr_accessor :items, :package
  
  def initialize
    @items = []
    @package
  end
  
  def add_package(pid)
    p = Package.find(pid)
    self.package = p 
  end
  
  def add_items(product_id)
    
    product = Product.find(product_id)
    
    items = product.check_for_interactive(@items)
    
    current_item = items.find {|item| item.cart_item == product_id}
    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(product_id)
    end
  end
  
  def remove_items(product_id)
    current_item = @items.find {|item| item.cart_item == product_id}
    current_item.decrement_quantity
    if current_item.quantity <= 0
      @items.reject! { |item| item.quantity <= 0 }
    end
  end
  
  def total_price
    item_prices = @items.sum {|item| item.price}
    
    if @package
      total_price = item_prices + @package.price
      return total_price
    else
      return item_prices
    end
  end
  
  def self.process_order(cart, billing)
    
    raise cart.to_yaml
    
  end
  
end
