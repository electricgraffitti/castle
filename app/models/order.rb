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
  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  
  #Methods
  
  def order_product_attributes=(attributes)
    attributes.each do |attr|
      order_products.build(attr)
    end
  end
  
  
  def self.process_order(return_url, cart, billing_info, total_price)

    values = {
      :MerchantID => APP["merchant_id"], 
      :RegKey => APP["reg_key"],
      :RURL => return_url,
      :Type => "CC",
      :Description => "Castle Protection Service Fee",
      :ABAExpire => process_cc_expiration(billing_info),
      :AccountNo => (billing_info[:credit_card]).to_i,
      :AccountName => process_account_name(billing_info),
      :RefID => cart.order_id,
      :Amount => total_price,
      :Address => billing_info[:address],
      :ZipCode => billing_info[:billing_zip],
      :BillingCycle => "M",
      :StartDate => start_date,
      :NoOfDebits => "2"
    }
    # Convert hash to query string
    qv = values.to_query
  end
  
  private
  
  def self.start_date
    return Date.today.strftime("%m/%d/%y")
  end
  
  def self.process_cc_expiration(billing_info)
    return process_exp_month(billing_info) + process_exp_year(billing_info)
  end
  
  def self.process_account_name(billing_info)
    return (billing_info[:first_name] + " " + billing_info[:last_name])
  end
  
  def self.process_exp_month(billing_info)
    case billing_info[:credit_card_expiration]["expiration_date(2i)"]
      when "1"
        return "01"
      when "2"
        return "02"
      when "3"
        return "03"
      when "4"
        return "04"
      when "5"
        return "05"
      when "6"
        return "06"
      when "7"
        return "07"
      when "8"
        return "08"
      when "9"
        return "09"
      when "10"
        return "10"
      when "11"
        return "11"
      when "12"
        return "12"
      end
  end
  
  def self.process_exp_year(billing_info)
    exp_year = billing_info[:credit_card_expiration]["expiration_date(1i)"]
    chomped_exp_year = exp_year[2,3]
    return chomped_exp_year
  end
  
end
