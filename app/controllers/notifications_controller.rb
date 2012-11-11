class NotificationsController < ApplicationController

	layout false

	def send_product_locations

		# Send Assigned Items
		Notifier.send_product_locations(current_user, params)

		respond_to do |format|
    	format.html { redirect_to(:back, notice: 'Assigned items sent to Castle LLC.') }
    end
	end

	def user_dash_contact_request

		Notifier.user_dash_contact_request(current_user, params)

		respond_to do |format|
    	format.html { dashboard_path, notice: 'Your support request has been sent.') }
    end
	end

end