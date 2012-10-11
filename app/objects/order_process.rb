class OrderProcess

	def self.create_new_order(params, price)
		customer = nil
		plan = nil
		subscription = nil
		fee = nil

		begin

			ActiveRecord::Base.transaction do

				# Create User
				@user = ObjectBuilder.create_new_user(params)
				@user.save!

				# Create Order
				@order = Order.new(params[:order])
				@order.user_id = @user.id
				@order.save!

				# Create Order Products
				OrderProduct.create_order_products(params, @order)

				# Create Stripe Customer
				customer = StripeCustomer.create_customer(params)

				# Create Stripe Plan
				plan = StripePlan.create_plan(price, params, @user)

				# Create Stripe Subscription
				subscription = StripeSubscription.create_subscription(customer, plan)

				# Charge Processing Fee
				fee = StripeCharge.create_charge(customer.id, price)

				# Update needed records
				@user.update_attributes(stripe_id: customer.id, stripe_plan_id: plan.id)


				# Send Confirmation Emails

			end

			return true
		rescue ActiveRecord::Rollback
			if customer
				StripeCustomer.delete_customer(customer.id)
			end
			if plan
				StripePlan.delete_plan(plan.id)
			end
			if subscription
				StripeSubscription.delete_subscription(subscription.id)
			end
			if fee
				StripeCharge.delete_charge(fee.id)
			end

			return false
		end

	end

end