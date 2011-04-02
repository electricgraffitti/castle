class DependentProduct < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :dependency, :class_name => "Product"
  
end
