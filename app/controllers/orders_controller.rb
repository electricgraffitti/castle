class OrdersController < ApplicationController
  
  before_filter :require_admin, only: [:index, :edit, :delete]
  skip_before_filter :verify_authenticity_token, only: :order_return
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render json: @order }
    end
  end

  def new # Step 1
    @cart = setup_cart

    @order = Order.new
    @user = User.new
    @billing_record = BillingRecord.new
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    processed_order = OrderProcess.create_new_order(params)
    @cart = setup_cart
    respond_to do |format|
      if processed_order
        @cart.order_id = @order.id
        format.html { redirect_to(dashboard_path, notice: 'Order Processed. Please complete product locations.') }
        format.json  { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json  { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(payment_info_path, notice: 'Order was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render action: "edit" }
        format.json  { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.json  { head :ok }
    end
  end
end