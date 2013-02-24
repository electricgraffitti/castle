class PagesController < ApplicationController

  before_filter :require_no_user
  
  def index
    @blog = Blog.last
  end
  
  def terms
    
  end
  
  def faq
    
  end
  
  def privacy_policy
    
  end
  
  def return_policy
    
  end
  
  def about
    @cart = setup_cart
    @packages = Package.order('id DESC')
    @products = Product.all(:order => "list_order")
    @blog = Blog.first
  end
  
  def contact
    @support = Support.new
    @product = Product.first
  end
  
  def products
    
  end
  

end
