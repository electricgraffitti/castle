class StripePlan

	require "stripe"

	def self.create_plan(price, params, user)
		timestamp = Time.now
		Stripe.api_key = APP["stripe_key"] # Get Key from app_config.yml
		plan = Stripe::Plan.create(
  		amount: Currency.calculate_dollars_to_cents(price),
  		interval: 'month',
  		name: "Castle Plan: #{user.last_name}_#{user.id}_#{timestamp.nsec}",
  		currency: 'usd',
  		id: "#{user.last_name}_#{user.id}_#{timestamp.nsec}",
  		trial_period_days: 30
		)
		return plan
	end

	def self.update_plan(plan_id)
		plan = get_plan(plan_id)
		# ... update values
		plan.save
	end

	def self.delete_plan(plan_id)
		plan = get_plan(plan_id)
		plan.delete
	end

	def get_plan(plan_id)
		plan = Stripe::Plan.retrieve(plan_id)
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end