class OrderProcess

	def self.create_new_order(params)

		# Create User
		@user = ObjectBuilder.create_new_user(params)
		raise @user.to_yaml

		# Create Stripe Plan

		# Create Stripe Subscription

		# Create Order

		# Create Order Products

		# Send Confirmation Emails

		ActiveRecord::Base.transaction do

			# Create new Order Record
			@order = Order.create(user_id: current_user.id)

			params[:order_product_attributes].each do |order_product|
			 op = OrderProduct.new(order_product[1])
			 op.order_id = @order.id
			end

		end
		return true
	end

end