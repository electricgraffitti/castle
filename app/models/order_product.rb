# == Schema Information
#
# Table name: order_products
#
#  id         :integer(4)      not null, primary key
#  order_id   :integer(4)
#  product_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class OrderProduct < ActiveRecord::Base
end
