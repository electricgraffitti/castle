# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  email               :string(255)
#  phone               :string(255)
#  terms               :boolean
#  username            :string(255)
#  stripe_id           :string(255)
#  stripe_plan_id      :string(255)
#  package_id          :integer
#  account_id          :integer
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer
#  failed_login_count  :integer
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  admin_user          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  
  # Associations
  belongs_to :account
  belongs_to :package
  has_many :orders
  has_many :order_products, through: :orders
  has_many :products, through: :order_products
  has_many :user_dependent_products
  has_many :products, through: :user_dependent_products
  has_many :billing_records

  # Validations
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :phone, presence: true, numericality: true
  validates :email,   
            presence: true,
            uniqueness: true,
            format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  # Scopes
  
  ################################### Methods

  # Authlogic
  acts_as_authentic do |c|
    c.login_field(:email)
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

  def monthly_rate
    current_plan = StripeSubscription.get_monthly_rate(self)
    return Currency.calculate_cents_to_dollars(current_plan.amount)
  end

  def dependent_products
    dependent_products = []
    user_dependent_products.each do |udp|
      dependent_products.push(udp.product)
    end
    return dependent_products 
  end

  def has_existing_interactive_product?
    dependent_products.each do |product|
      if product.interactive_service
        return true
      else
        return false
      end
    end
  end
  
end

