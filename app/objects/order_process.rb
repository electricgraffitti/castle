class OrderProcess

	def self.create_new_order(params, package_id, price, cart)
		customer = nil
		plan = nil
		subscription = nil
		fee = nil

		begin
			ActiveRecord::Base.transaction do

				# Create User
				@user = ObjectBuilder.create_new_user(params)
				@user.package_id = package_id
				@user.save!

				# Create Order
				@order = Order.new(params[:order])
				@order.user_id = @user.id
				@order.save!

				# Create Billing Record
				BillingRecord.create_new_billing_record(@user, params)

				# Create Additional Information Records
				AdditionalServiceRecord.create_new_additional_service_record(@user, params)

				# Create User Interactive Products
				UserInteractiveProduct.create_user_interactive_products(params, @user)

				# Create User Owned Dependant Products
				UserDependentProduct.create_user_dependent_products(params, @user)

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
				@order.update_attributes(stripe_invoice_id: plan.id)

				# Send Confirmation Emails
				Notifier.successful_order_admin(@user, cart, @order).deliver
				Notifier.successful_order_customer(@user, cart, @order, plan).deliver
				return true
			end
		rescue Exception => e
			if fee
				fee.refund
			end
			if subscription
				customer.cancel_subscription
			end
			if plan
				plan.delete
			end					
			if customer
				customer.delete
			end
			return false
		end		
	end

	def self.create_addon_order(user, params, price, cart)
		customer = nil
		plan = nil
		subscription = nil
		old_plan = StripePlan.get_plan(user.stripe_plan_id)

		begin
			ActiveRecord::Base.transaction do
			
				# Create Order
				@order = Order.new(params[:order])
				@order.user_id = user.id
				@order.terms = 1
				@order.save!

				# Create User Interactive Products
				UserInteractiveProduct.create_user_interactive_products(params, @user)

				# Create User Owned Dependant Products
				UserDependentProduct.create_user_dependent_products(params, user)

				# Create Order Products
				OrderProduct.create_order_products(params, @order)

				# Create Stripe Customer
				customer = StripeCustomer.get_customer(user)

				# Create Stripe Plan
				plan = StripePlan.create_updated_plan(price, params, user)

				# Create Stripe Subscription
				subscription = StripeSubscription.update_subscription(customer, plan)

				# Update needed records
				user.update_attributes(stripe_plan_id: plan.id)
				@order.update_attributes(stripe_invoice_id: plan.id)

				# Send Confirmation Emails
				Notifier.successful_update_order_admin(@order, cart, user, old_plan, plan).deliver
				Notifier.successful_update_order_customer(@order, cart, user, old_plan, plan).deliver
				return true
			end
		rescue Exception => e
				if plan
					plan.delete
				end
				if subscription
					StripeSubscription.update_subscription(customer, old_plan)
				end
				return false
		end
	end

end