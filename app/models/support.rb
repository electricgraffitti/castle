# == Schema Information
#
# Table name: supports
#
#  id           :integer(4)      not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  email        :string(255)
#  phone        :string(255)
#  city         :string(255)
#  state_id     :integer(4)
#  zipcode      :string(255)
#  support_type :string(255)
#  comments     :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Support < ActiveRecord::Base
  
  belongs_to :state
  
  include ActiveModel::Validations

  validates_presence_of :first_name, :last_name, :email, :phone, :support_type, :city, :state_id, :zipcode
  
  def send_contact_mail
    Notifier.support_notification(self).deliver
  end

end
