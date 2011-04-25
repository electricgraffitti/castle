class PackagedProduct < ActiveRecord::Base
  
  belongs_to :package
  belongs_to :product
  
end
