# == Schema Information
#
# Table name: orders
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  complete   :boolean(1)
#

class Order < ActiveRecord::Base
    
  #Associtations
  belongs_to :user
  
  has_many :billing_records
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  # Attrs
  attr_accessor :stripe_card_token

  # Validations
  validates :terms, presence: true
  
  #Methods

  def order_owner
    user.full_name
  end

  def order_date
    created_at.strftime("Ordered on %m/%d/%Y")
  end

end
