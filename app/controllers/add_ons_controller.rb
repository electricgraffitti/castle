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
    raise params.to_yaml
  end
  
end
