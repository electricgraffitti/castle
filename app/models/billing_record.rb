# == Schema Information
#
# Table name: billing_records
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  order_id    :integer
#  city        :string(255)
#  address     :string(255)
#  billing_zip :string(255)
#  state_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class BillingRecord < ActiveRecord::Base
  
  # Associations
  belongs_to :order
  belongs_to :state
  belongs_to :user
  
  # Validations
  
  validates :city, :presence => true
  validates :address, :presence => true
  validates :billing_zip, :presence => true, :numericality => true, :length => { :minimum => 5, :maximum => 5 }
  validates :phone, :presence => true, :numericality => true, :length => { :minimum => 10, :maximum => 10 }
  validates :state_id, :presence => true
  validates :order_id, :presence => true
  
end
