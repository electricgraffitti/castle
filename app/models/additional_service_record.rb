# == Schema Information
#
# Table name: additional_service_records
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  cross_street       :string(255)
#  permit_info        :text
#  secondary_phone    :string(255)
#  subdivision        :string(255)
#  emergency_name     :string(255)
#  emergency_password :string(255)
#  secondary_address  :string(255)
#  secondary_city     :string(255)
#  state_id           :integer
#  secondary_zip      :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class AdditionalServiceRecord < ActiveRecord::Base

	# Associations
	belongs_to :user
  belongs_to :state
  	
  # Validations
  validates :secondary_city, :presence => true
  validates :secondary_address, :presence => true
  validates :secondary_zip, :presence => true, :numericality => true, :length => { :minimum => 5, :maximum => 5 }
  validates :state_id, :presence => true


  # Methods
  
  def self.create_new_additional_service_record(user, params)
  	self.create(
      user_id: user.id,
      cross_street: params[:additional_service_record][:cross_street],
      permit_info: params[:additional_service_record][:permit_info],
      secondary_phone: params[:additional_service_record][:secondary_phone],
      subdivision: params[:additional_service_record][:subdivision],
      emergency_name: params[:additional_service_record][:emergency_name],
      emergency_password: params[:additional_service_record][:emergency_password],
      secondary_address: params[:additional_service_record][:address],
      secondary_city: params[:additional_service_record][:city],
      state_id: params[:additional_service_record][:state_id],      
      secondary_zip: params[:additional_service_record][:secondary_zip]
    )	
  end


end
