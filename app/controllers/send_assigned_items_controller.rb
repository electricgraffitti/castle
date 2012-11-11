class SendAssignedItemsController < ApplicationController

	before_filter :require_user
	layout false

  def new
  end

  def create
  	products = OrderProduct.create_list_of_assigned_products_to_send(params)
  	OrderProduct.finalize_products(products)
  	Notifier.send_product_locations(current_user, products).deliver
  	redirect_to dashboard_path, :notice => "Your list of products has been sent for location programming."  	
  end
end
