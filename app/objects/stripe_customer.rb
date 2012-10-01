class StripeCustomer

	require "stripe"

	def self.create_customer(params)
		Stripe.api_key = APP["stripe_key"] # Get Key from app_config.yml
    customer = Stripe::Customer.create(
              :card => params[:order][:stripe_card_token],
              :email => params[:user][:email],
              :description => params[:user][:email]
    )
    return customer
	end

	def self.update_customer
		
	end

	def self.delete_customer
		
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end