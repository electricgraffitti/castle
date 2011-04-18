# == Schema Information
#
# Table name: dependent_products
#
#  id            :integer(4)      not null, primary key
#  product_id    :integer(4)
#  dependency_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class DependentProduct < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :dependency, :class_name => "Product"
  
end
