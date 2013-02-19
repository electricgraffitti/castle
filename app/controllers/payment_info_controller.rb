class PaymentInfoController < ApplicationController

  before_filter :require_user, except: [:new]

  def new
    @cart = setup_cart

    if @cart.billing_record_id
      @billing_record = BillingRecord.find(@cart.billing_record_id)
    else 
      @billing_record = BillingRecord.new
    end
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @products }
    end
  end

  def update_user_information

    @updated_user = StripeCustomer.update_customer(current_user, params)

    respond_to do |format|
      if @updated_user
        format.html { redirect_to(user_account_path, notice: 'User was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { redirect_to :back, notice: "Processing Error. Please try again."}
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

  def update_credit_card_information
    
    @updated_cc = StripeCustomer.update_credit_card(current_user, params)

    respond_to do |format|
      if @updated_cc
        Notifier.successful_user_update_admin(current_user, "Credit Card").deliver
        Notifier.successful_user_update_customer(current_user, "Credit Card").deliver
        format.html { redirect_to(user_account_path, notice: 'Your payment source was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { redirect_to user_account_path, notice: "Processing Error. Please try again."}
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end  
  end

  def update_additional_information
    
    @updated_additional_info = current_user.additional_service_record

    respond_to do |format|
      if @updated_additional_info.update_attributes(params[:additional_service_record])
        Notifier.successful_user_update_admin(current_user, "Additional Service Record").deliver
        Notifier.successful_user_update_customer(current_user, "Additional Service Record").deliver
        format.html { redirect_to(user_account_path, notice: 'Additional Service Record was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { redirect_to user_account_path, notice: "Processing Error. Please try again."}
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end      
  end

  def update_billing_information
  
    @updated_billing = current_user.billing_record

    respond_to do |format|
      if @updated_billing.update_attributes(params[:billing_record])
        Notifier.successful_user_update_admin(current_user, "Billing Record").deliver
        Notifier.successful_user_update_customer(current_user, "Billing Record").deliver
        format.html { redirect_to(user_account_path, notice: 'Billing Record was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { redirect_to user_account_path, notice: "Processing Error. Please try again."}
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

end
