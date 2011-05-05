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
  
end
