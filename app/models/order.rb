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
  
  has_many :order_products
  has_many :products, :through => :order_products
  
  
  def process_order(return_url, cart)
    
    values = {
      :MerchantID => '65628', 
      :RegKey => '_cart',
      :RURL => return_url,
      :Type => "CC",
      :ABAExpire => 0314,
      :AccountNo => 4656056023461645,
      :AccountName => "Robert Hanson",
      :RefID => "1",
      :Amount => 23.00,
      :Address => "123 Some Street",
      :ZipCode => "84084",
      :BillingCycle => "M",
      :StartDate => "051211",
      :NoOfDebits => "0"
    }
    "https://webservices.primerchants.com/billing/TransactionCentral/AddRecurring.asp?"+values.map { |k,v| "#{k}=#{v}"}.join("&")
  end
  
end
