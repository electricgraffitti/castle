# == Schema Information
#
# Table name: billing_records
#
#  id          :integer(4)      not null, primary key
#  terms       :boolean(1)
#  city        :string(255)
#  address     :string(255)
#  billing_zip :string(255)
#  phone       :string(255)
#  first_name  :string(255)
#  last_name   :string(255)
#  state_id    :integer(4)
#  email       :string(255)
#  order_id    :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class BillingRecord < ActiveRecord::Base
  
  # Associations
  belongs_to :order
  belongs_to :state
  
  # Validations
  validates :terms, :presence => true
  validates :city, :presence => true
  validates :address, :presence => true
  validates :billing_zip, :presence => true, :numericality => true, :length => { :minimum => 5, :maximum => 5 }
  validates :phone, :presence => true, :numericality => true, :length => { :minimum => 10, :maximum => 10 }
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :state_id, :presence => true
  validates :email,   
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :order_id, :presence => true

  # Attrs
  attr_accessor :stripe_card_token
  
  
end
