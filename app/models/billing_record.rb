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
  belongs_to :user
  belongs_to :state
  
  # Validations
  
  validates :city, :presence => true
  validates :address, :presence => true
  validates :billing_zip, :presence => true, :numericality => true, :length => { :minimum => 5, :maximum => 5 }
  validates :state_id, :presence => true

  def self.create_new_billing_record(user, params)
    self.create(
      user_id: user.id, 
      city: params[:billing_record][:city], 
      address: params[:billing_record][:address],
      billing_zip: params[:billing_record][:billing_zip],
      state_id: params[:billing_record][:state_id]
    )
  end
  
end
