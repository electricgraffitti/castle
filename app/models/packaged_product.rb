# == Schema Information
#
# Table name: packaged_products
#
#  id              :integer(4)      not null, primary key
#  package_id      :integer(4)
#  product_id      :integer(4)
#  included_amount :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

class PackagedProduct < ActiveRecord::Base
  
  belongs_to :package
  belongs_to :product
  
end
