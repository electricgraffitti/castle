class OrdersController < ApplicationController
  
  before_filter :require_admin, :only => [:index, :edit, :delete]
  skip_before_filter :verify_authenticity_token, :only => :order_return
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :xml => @order }
    end
  end

  def new # Step 1
    @cart = setup_cart
    if @cart.order_id
      @order = Order.find(@cart.order_id)
    else
      @order = Order.new
    end
    @package = Package.find(@cart.package_id)
    @order.order_products.build if @order.order_products.blank?

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    # raise params.to_yaml
    @order = Order.new(params[:order])
    @cart = setup_cart
    respond_to do |format|
      if @order.save
        @cart.order_id = @order.id
        format.html { redirect_to(payment_info_path, :notice => 'Step 1 Completed. Step 2 Payment Information.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(payment_info_path, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
  
  def cart_checkout # Step 3
    raise params.to_yaml
    @cart = setup_cart
    if @cart.billing_record_id
      @billing_record = BillingRecord.find(@cart.billing_record_id)
      @billing_record.update_attributes(params[:billing_record])
    else 
      params[:billing_record][:order_id] = @cart.order_id
      @billing_record = BillingRecord.new(params[:billing_record])
      @billing_record.save
      @cart.billing_record_id = @billing_record.id
      @cart.acnum = (params[:credit_card]).to_i
      @cart.abaex = Order.process_cc_expiration(params)
    end
    @package = Package.find(@cart.package_id)
  end
  
  def tc_process_order
    @cart = setup_cart
    
    # This processes the order and the fee transaction
    recurring_response = Order.process_order(@cart)
    
    respond_to do |format|
      if recurring_response
        format.html { redirect_to order_return_path(recurring_response)}
      else
        formet.html {redirect_to payment_info_path, :notice => "There was a problem processing your order. Please try again."}
      end
    end
  end
  
  def order_return
    # Empty nil order_product records to keep DB clean
    OrderProduct.delete_empty_records

    # set cart for one last display need
    @cart = setup_cart
    # setup order complete (add recurring id to order)
    @order = Order.find(params[:order_id])
    @order.complete = true
    @order.save
    
    # Vars for page display
    @order_id = params[:order_id]
    @tc_trans_id = params[:fee_transaction_id]
    @tc_recurring_id = params[:recurring_id]
    @auth = params[:fee_auth_code]
    
    # Setup Castle Admin Mailer
    Notifier.successful_order_admin(@order, @tc_id, @tc_recurring_id, @auth, @cart).deliver
    # Setup Customer Mailer
    Notifier.successful_order_customer(@order, @tc_id, @tc_recurring_id, @cart).deliver
    
    # Finally clear the cart in session
    session[:cart] = nil
    respond_to do |format|
      format.html
    end
  end
  
end
