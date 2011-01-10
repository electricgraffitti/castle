class User < ActiveRecord::Base
  
  include Permissions
  
  # Associations
  belongs_to :account

  # Validations
  validates_presence_of :first_name, :last_name, :email, :username, :password, :password_confirmation, :phone, :on => :create, :message => "can't be blank"
  validates_length_of :first_name, :last_name, :minimum => 2, :on => :create, :message => "Minimum 2 letters required."
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message => "Enter a Valid Email"


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

