class NotificationsController < ApplicationController

	layout false

	def send_assigned_items

		# Send Assigned Items
		

		respond_to do |format|
    	format.html { redirect_to(:back, notice: 'Assigned items sent to Castle LLC.') }
    end
	end

end