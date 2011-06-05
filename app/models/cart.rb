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
  
  attr_accessor :items, :package_id, :package_name, :order_id, :billing_record_id, :acnum, :abaex, :combo_item
  
  def initialize
    @items = []
    @package_id
    @package_name
    @order_id
    @billing_record_id
    @combo_item
    # CC num
    @acnum
    # CC exp
    @abaex
  end
  
  def add_package(pid)
    p = Package.find(pid)
    self.package_id = p.id
    self.package_name = p.name
  end
  
  def combo_item?
    if self.combo_item
      return true
    else
      return false
    end
  end
  
  def add_items(product_id)
    
    product = Product.find(product_id)
    
    ci_items = product.check_for_interactive(@items)
    
    items = product.check_for_combo_items(ci_items)
    
    current_item = items.find {|item| item.cart_item == product_id}
    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(product_id)
    end
  end
  
  def remove_items(product_id)
    current_item = @items.find {|item| item.cart_item == product_id}
    if current_item.combo_item
      self.combo_item = false
    end
    current_item.decrement_quantity
    if current_item.quantity <= 0
      @items.reject! { |item| item.quantity <= 0 }
    end
  end
  
  def total_price
    item_prices = @items.sum {|item| item.price}
    
    if @package_id
      p = Package.find(@package_id)
      total_price = item_prices + p.price
      return total_price
    else
      return item_prices
    end
  end
  
end
