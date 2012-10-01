class OrderProcess

	def self.create_new_order(params)
		customer = nil
		plan = nil
		subscription = nil

		begin

			ActiveRecord::Base.transaction do

			# Create User
			@user = ObjectBuilder.create_new_user(params)
			@user.save!

			# Create Account

			# Create Order
			@order = Order.create(user_id: @user.id)
			@order.save!

			# Create Order Products
			OrderProduct.create_order_products(params, @order)

			# Create Stripe Customer
			customer = StripeCustomer.create_customer(params)

			# Create Stripe Plan
			plan = StripePlan.create_plan(params, @user)

			# Create Stripe Subscription
			subscription = StripeSubscription.create_subscription(plan, customer)

			# Send Confirmation Emails

			end

			return true
		rescue ActiveRecord::RecordInvalid => invalid
			return false
		end

	end

end