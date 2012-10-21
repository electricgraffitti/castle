# == Schema Information
#
# Table name: systems
#
#  id         :integer          not null, primary key
#  product_id :integer
#  package_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class System < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :package
  
end
