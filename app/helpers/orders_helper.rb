module OrdersHelper

	def order_header
		current_user ? "Your Orders" : "All Orders"
	end

end
