class PagesController < ApplicationController
  
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
    @packages = Package.order('id DESC')
    @products = Product.all(:order => "list_order")
    @product = Product.last
  end
  
  def contact
    @support = Support.new
    @product = Product.first
  end
  
  def products
    
  end
  

end
