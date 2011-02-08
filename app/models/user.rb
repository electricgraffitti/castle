# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  email               :string(255)
#  username            :string(255)
#  account_id          :integer(4)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer(4)
#  failed_login_count  :integer(4)
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  phone               :string(255)
#  terms               :boolean(1)
#  admin_user          :boolean(1)
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  
  # Associations
  belongs_to :account
  has_many :carts
  has_many :orders

  # Validations
  validates :first_name, :presence => true, :length => { :minimum => 2 }
  validates :last_name, :presence => true, :length => { :minimum => 2 }
  validates :phone, :presence => true, :numericality => true
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}


  # Paperclip

  # Scopes
  
  ################################### Methods

  # Authlogic
  acts_as_authentic do |c|
    c.logged_in_timeout = 120.minutes
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notify.password_reset(self).deliver
  end

  def full_name
    full_name = self.first_name + " " + self.last_name
    return full_name
  end
  
end

