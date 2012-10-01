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
				@order = Order.new(params[:order])
				@order.user_id = @user.id
				@order.save!

				# Create Order Products
				OrderProduct.create_order_products(params, @order)

				# Create Stripe Customer
				customer = StripeCustomer.create_customer(params)
				@user.update_attribute(:stripe_id, customer.id)

				# # Create Stripe Plan
				# plan = StripePlan.create_plan(params, @user)

				# # Create Stripe Subscription
				# subscription = StripeSubscription.create_subscription(plan, customer)

				# Send Confirmation Emails

			end

			return true
		rescue ActiveRecord::Rollback
			if customer
				StripeCustomer.delete_customer(customer.id)
			end
			return false
		end

	end

end