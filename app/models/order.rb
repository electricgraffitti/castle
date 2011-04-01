# == Schema Information
#
# Table name: orders
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  complete   :boolean(1)
#

class Order < ActiveRecord::Base
  
  #Associtations
  belongs_to :user
  
  has_many :order_products
  has_many :products, :through => :order_products
  
end
