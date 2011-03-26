# == Schema Information
#
# Table name: systems
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  package_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class System < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :package
  
end
