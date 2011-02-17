# == Schema Information
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  complete   :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  
  #Associtations
  belongs_to :user
  has_many :cart_items, :dependent => :destroy
  has_one :package, :through => :cart_items
  has_many :products, :through => :cart_items
  
  attr_accessible :items
  
  def initialize
    @items = []
  end
  
end
