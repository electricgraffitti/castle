# == Schema Information
#
# Table name: dependent_products
#
#  id            :integer          not null, primary key
#  product_id    :integer
#  dependency_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class DependentProduct < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :dependency, :class_name => "Product"
  
end
