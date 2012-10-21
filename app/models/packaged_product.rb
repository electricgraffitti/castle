# == Schema Information
#
# Table name: packaged_products
#
#  id              :integer          not null, primary key
#  package_id      :integer
#  product_id      :integer
#  included_amount :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class PackagedProduct < ActiveRecord::Base
  
  belongs_to :package
  belongs_to :product
  
end
