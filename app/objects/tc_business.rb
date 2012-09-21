class TcBusiness

	def self.process_order(cart)
    billing_info = BillingRecord.find(cart.billing_record_id)

    params = {
      :MerchantID => APP["merchant_id"],
      :RegKey => APP["reg_key"],
      :RURL => "",
      :Description => APP["charge_description"],
      :TransType => "CC",
      :ABAExpire => cart.abaex,
      :AccountNo => cart.acnum,
      :AccountName => Order.process_account_name(billing_info),
      :RefID => cart.order_id,
      :Amount => cart.total_price,
      :Address => billing_info.address,
      :ZipCode => billing_info.billing_zip,
      :BillingCycle => "M",
      :StartDate => Order.start_date,
      :NoOfDebits => "2",
      
      # These are set because I guess TC is too stupid to set them empty if not passed.
      :PONumber => "",
      :TaxAmount => "",
      :TaxIndicator => ""
    }
    
    response = Order.post_request(APP["recurring_url"], params)
    
    # Check the response code from recurring for success
    if response.code == "200"
      
      # if success process the repsonse to a param hash
      order_params = Order.process_response(response)
      
      # if the Notes params is empty it was a success so we process now process the Fee and it repeats the same steps
      if order_params["Notes"] == ""
        fee_response = Order.process_fees(cart)
        
        if fee_response.code == "200"
          fee_params = Order.process_response(fee_response)
          
          if fee_params["Notes"] == ""
            combined_params = Order.combine_params(order_params, fee_params)
            return combined_params
          else
            return false
          end
          
        else
          return false
        end
        
      else
        return false
      end
      
    else
      return false
    end
  end
  
  def self.process_fees(cart)
    
    params = {
      :MerchantID => APP["merchant_id"],
      :RegKey => APP["reg_key"],
      :Amount => APP["process_fee"],
      :RefID => cart.order_id,
      :AccountNo => cart.acnum,
      :CCMonth => Order.split_expiration_month(cart.abaex),
      :CCYear => Order.split_expiration_year(cart.abaex),
      :CCRURL => "",
      :TaxAmount => "",
      :PONumber => "",
      :TaxIndicator => "",
      :NameonAccount => "",
      :AVSADDR => "",
      :AVSZIP => "",
      :CVV2 => "",
      :USER1 => "",
      :USER2 => "",
      :USER3 => "",
      :USER4 => ""
    }
    
    response = Order.post_request(APP["single_charge_url"], params)
    return response      
  end
  
  def self.post_request(tc_url, params)
    url = URI.parse(tc_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data(params)
    response = http.request(request)
    
    return response
  end
  
  def self.process_response(response)
    
    # Use Nokogiri to extract the return string from the TC repsonse
    strip_html_from_repsonse = Nokogiri::HTML(response.body)
    extracted_query_string = strip_html_from_repsonse.at_css("body").text
    # Parse the extracted string into a hash
    hashed_values = Rack::Utils.parse_query(extracted_query_string)
    
    return hashed_values
  end
  
  def self.combine_params(order_params, fee_params)

    params = {
      :recurring_id => order_params["RecurringID"],
      :order_id => order_params["RefNo"],
      :fee_transaction_id => fee_params["TransID"],
      :fee_auth_code => fee_params["Auth"]  
    }
    
    return params
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
  
  def self.split_expiration_month(abaex)
    month = abaex.split(//)
    return month[0] + month[1]
  end
  
  def self.split_expiration_year(abaex)
    year = abaex.split(//)
    return year[2] + year[3]
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