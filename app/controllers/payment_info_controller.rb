class PaymentInfoController < ApplicationController

	def new
		@cart = setup_cart

    if @cart.billing_record_id
      @billing_record = BillingRecord.find(@cart.billing_record_id)
    else 
      @billing_record = BillingRecord.new
    end
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
	end

end
