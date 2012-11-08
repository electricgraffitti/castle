class OrdersController < ApplicationController
  
  before_filter :require_admin, only: [:edit, :delete]
  before_filter :require_auth, only: [:index, :show]
  
  def index
    @orders = Order.all
    @invoices = StripeCustomer.get_invoices(current_user)

    respond_to do |format|
      format.html { render layout: 'internal'}
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

  def new
    @cart = setup_cart

    @order = Order.new
    @user = User.new
    @billing_record = BillingRecord.new
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @cart = setup_cart
    package_id = @cart.package_id
    price = @cart.total_price
    @order = OrderProcess.create_new_order(params, package_id, price)
    respond_to do |format|
      if @order
        session[:cart] = nil
        format.html { redirect_to(dashboard_path, notice: 'Order Processed. Please complete product locations.') }
        format.json  { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new", notice: "Processing Error." }
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