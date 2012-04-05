class StripeCustomer

	require "stripe"

	def self.create_customer
		
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