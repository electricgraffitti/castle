class OrdersController < ApplicationController
  
  before_filter :require_admin, :only => [:index, :edit, :delete]
  
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

  def new
    @order = Order.new
    @cart = setup_cart
    @package = Package.find(@cart.package_id)
    @order.order_products.build
    @billing_info = params
    
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
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
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
  
  def process_order
    cart = setup_cart
    package = Package.find(cart.package_id)
    billing_info = params
    return_url = order_return_url
    processing_fee = 30
    total_price = (cart.total_price + package.price)
    Cart.process_order(return_url, cart, billing_info, total_price)
  end
  
  def cart_checkout
    @user = User.new
    @cart = setup_cart
    @package = Package.find(@cart.package_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  
  def order_return
    
  end
  
end
