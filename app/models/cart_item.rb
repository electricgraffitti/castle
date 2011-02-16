# == Schema Information
#
# Table name: cart_items
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  cart_id    :integer(4)
#  notes      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CartItem < ActiveRecord::Base
  
  #Validations
  validates :notes, :presence => true, :uniqueness => true
  
  #Associations
  belongs_to :cart
  belongs_to :product
  belongs_to :package
  
end
