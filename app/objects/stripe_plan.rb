class StripePlan

	require "stripe"

	def self.create_plan(params)
		plan = Stripe::Plan.create(
  		:amount => params[:amount],
  		:interval => 'month',
  		:name => 'Castle',
  		:currency => 'usd',
  		:id => "user_last_name + user_id"
		)
		return plan
	end

	def self.update_plan(plan_id)
		plan = StripeInteface.get_plan(plan_id)
		# ... update values
		plan.save
	end

	def self.delete_plan
		
	end

	def get_plan(plan_id)
		plan = Stripe::Plan.retrieve(plan_id)
	end

	def self.create_subscription
		
	end

	def self.update_subscription
		
	end

	def self.delete_subscrition
		
	end

	def create_charge
		
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end