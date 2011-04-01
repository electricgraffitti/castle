# == Schema Information
#
# Table name: orders
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  cart_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  
  #Associtations
  belongs_to :user
end
