class AddOnsController < ApplicationController

	before_filter :require_user

  layout "internal"

  def index
  	@cart = setup_cart
  	@package = current_user.package
    @cart_has_combo_item = @cart.combo_item?
    @blog = Blog.last
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @cart = setup_cart
    price = @cart.total_price + current_user.monthly_rate
    @order = OrderProcess.create_addon_order(current_user, params, price, @cart)
    respond_to do |format|
      if @order
        session[:cart] = nil
        format.html { redirect_to(dashboard_path, notice: 'Add-On Order Processed. Please complete product locations if necessary.') }
        format.json  { render json: @order, status: :created, location: @order }
      else
        format.html { redirect_to(dashboard_path, notice: "Processing Error.") }
        format.json  { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
