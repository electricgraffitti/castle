class SupportsController < ApplicationController
  
  def contact_email
    
    @support = Support.new(params[:support])
    
    if @support.valid?
      @support.send_contact_mail
      redirect_to root_path, :notice => "Support was successfully sent."
    else
      redirect_to :back, :notice => "You must fill all fields."
    end
  end


  def user_dash_contact_request
  	Notifier.user_dash_contact_request(current_user, params).deliver
		redirect_to dashboard_path, :notice => "Message was successfully sent."  	
  end
end
