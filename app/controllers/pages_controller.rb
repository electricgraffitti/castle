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
    @product = Product.last
  end
  
  def contact
    
  end
  
  def products
    
  end
  

end
