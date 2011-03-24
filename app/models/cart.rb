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
  
  def add_items(pid)
    item = Product.find(pid)
    self.items.push(item)
  end
  
end
