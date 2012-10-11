class StripeCharge

	require "stripe"

	def self.create_charge(customer_stripe_id, price)
		Stripe.api_key = APP["stripe_key"]
		Stripe::Charge.create(
  		amount: Currency.calculate_dollars_to_cents(APP["process_fee"] + price),
  		customer: customer_stripe_id,
  		currency: "usd",
  		description: "Setup Fee"
		)
	end

	def self.update_charge
		
	end

	def self.delete_charge
		
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end