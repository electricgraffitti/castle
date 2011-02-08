class Support < ActiveRecord::Base
  
  belongs_to :state
  
  include ActiveModel::Validations

  validates_presence_of :first_name, :last_name, :email, :phone, :support_type, :city, :state_id, :zipcode
  
  def send_contact_mail
    Notifier.support_notification(self).deliver
  end

end
