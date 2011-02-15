# == Schema Information
#
# Table name: carts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  complete   :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#  package_id :integer(4)
#

class Cart < ActiveRecord::Base
  
  #Associtations
  belongs_to :user
  has_many :cart_items
  has_many :products
  belongs_to :package
  
end
