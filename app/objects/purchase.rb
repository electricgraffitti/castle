class Purchase

	def self.create_purchase(params)
		customer = StripeCustomer.create_plan(params)
		charge = StripeCharge.create_plan(params, customer)
		plan = StripePlan.create_plan(params, customer)
		subscription = StripePlan.create_subscription(params, customer, plan)
		account = Account.create!(params)
		user = User.create!(params)
		Order.create(params, user)
	end

end