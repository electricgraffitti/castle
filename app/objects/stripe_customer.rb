class StripeCustomer

	require "stripe"

	def self.create_customer(params)
		Stripe.api_key = APP["stripe_key"] # Get Key from app_config.yml
    customer = Stripe::Customer.create(
              :card => params[:order][:stripe_card_token],
              :email => params[:user][:email],
              :description => params[:user][:email]
    )
    return customer
	end

	def self.get_customer(user)
		Stripe::Customer.retrieve(user.stripe_id)
	end

	def self.update_customer(user, params)
		existing_customer_record = StripeCustomer.get_customer(user)
		customer = existing_customer_record

		begin
			ActiveRecord::Base.transaction do
			
				# Update User in Local
				user.update_attributes(params[:user])

				# Update User in Stripe
				customer.email = params[:user][:email]
				customer.save

				# Send Confirmation Emails
				Notifier.successful_user_update_admin(user, "User Record").deliver
				Notifier.successful_user_update_customer(user, "User Record").deliver
				return true
			end
		rescue Exception => e
			customer.email = existing_customer_record.email
			customer.save
			return false
		end		
	end

	def self.update_credit_card(user, params)
		customer = StripeCustomer.get_customer(user)

		begin
			ActiveRecord::Base.transaction do
				binding.pry
				customer.card = params[:stripe_card_token]
				customer.save

				return true
			end
		rescue Exception => e
			return false
		end		
	end

	def self.delete_customer
	end

	def self.get_invoices(user)
		Stripe::Invoice.all(
		  :customer => user.stripe_id
		)
	end

	private

	def retrieve_stripe_key
    return Stripe.api_key = APP["stripe_key"]
  end

end