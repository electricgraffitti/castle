class StripeSubscription

	require "stripe"

	def self.create_subscription
		
	end

	def self.update_subscription
		
	end

	def self.delete_subscrition
		
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end