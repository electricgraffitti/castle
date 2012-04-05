class StripeCharge

	require "stripe"

	def self.create_charge
		
	end

	def self.update_charge
		
	end

	def self.delete_charge
		
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end