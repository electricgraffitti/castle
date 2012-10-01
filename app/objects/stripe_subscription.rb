class StripeSubscription

	require "stripe"

	def self.create_subscription(customer, plan)
		Stripe.api_key = APP["stripe_key"] # Get Key from app_config.yml
		customer.update_subscription(
			plan: plan,
			trial_end: 60.days_from_now
		)
	end

	def self.update_subscription
		
	end

	def self.cancel_subscrition(customer)
		customer.cancel_subscription(at_period_end: true)
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end