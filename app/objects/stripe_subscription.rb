class StripeSubscription

	require "stripe"

	def self.create_subscription(customer, plan)
		Stripe.api_key = APP["stripe_key"] # Get Key from app_config.yml
		customer.update_subscription(plan: plan.id)
	end

	def self.update_subscription
		
	end

	def self.delete_subscription(customer)
		customer.cancel_subscription(at_period_end: true)
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end