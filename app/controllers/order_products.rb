class OrdersController < ApplicationController
  
  before_filter :require_user

  def update
    @order_product = OrderProduct.find(params[:id])

    respond_to do |format|
      if @order_product.update_attributes(params[:order_product])
        format.html { redirect_to(:back, notice: 'Product was successfully updated.') }
        format.json  { render json: @order_product, status: 200 }
      else
        format.html { render action: "edit" }
        format.json  { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end