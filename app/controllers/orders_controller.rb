class OrdersController < ApplicationController
  
  before_filter :require_admin, :only => [:index, :edit, :delete]
  skip_before_filter :verify_authenticity_token, :only => :order_return
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
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
      format.xml  { render :xml => @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
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
  
  def payment_info # Step 2
    @cart = setup_cart
    if @cart.billing_record_id
      @billing_record = BillingRecord.find(@cart.billing_record_id)
    else 
      @billing_record = BillingRecord.new
    end
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  
  def cart_checkout # Step 3
    @cart = setup_cart
    if @cart.billing_record_id
      @billing_record = BillingRecord.find(@cart.billing_record_id)
      @billing_record.update_attributes(params[:billing_record])
    else 
      params[:billing_record][:order_id] = @cart.order_id
      @billing_record = BillingRecord.new(params[:billing_record])
      @billing_record.save
      @cart.billing_record_id = @billing_record.id
    end
    @package = Package.find(@cart.package_id)
    @return_url = order_return_url
    @expiration = Order.process_cc_expiration(params) 
    @account_name = Order.process_account_name(params[:billing_record])
    @cc = (params[:credit_card]).to_i
  end
  
  def order_return
    OrderProduct.delete_empty_records
    
    @notes = params[:Notes]
    
    if @notes = ""
      # setup order complete (add recurring id to order)
      @order = Order.find(params[:RefNo])
      @order.complete = true
      @order.save
      
      # Need to setup second TC post to bill setup fee
      
      # Setup Castle Admin Mailer
      
      # Setup Customer Mailer
      
      @order_id = params[:RefNo]
      @tc_id = params[:RecurringID]
      @cart = setup_cart
    else
      respond_to do |format|
        format.html redirect_to payment_info_path, :notice => "There was a problem processing your order. Please try again."
      end
    end
    
  end
  
end
