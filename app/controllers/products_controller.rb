class ProductsController < ApplicationController
  
  before_filter :require_admin, :except => [:index, :add_items, :empty_cart, :remove_items, :cart_checkout ]
  
  # GET /products
  # GET /products.xml
  def index
    
    @cart = setup_cart
    
    if params[:package_id]
      @cart.add_package(params[:package_id])
      @package = Package.find(params[:package_id])
    elsif @cart.package_id
      @package = Package.find(@cart.package_id)
    else
      @package = Package.find_by_name("Simon XT Pro Plus Package")
    end
    
    @cart_has_combo_item = @cart.combo_item?
    
    @blog = Blog.last
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @product.photos.build
    @listings = Product.order.product_order
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @listings = Product.order.product_order
    @has_dependent_products = @product.dependent_checkbox
    
    if @product.photos.blank?
       @product.photos.build
    end
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_dashboard_path, :notice => 'Product was successfully created.' }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_dashboard_path, :notice => 'Product was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  def add_items
    @cart = setup_cart
    
    @cart.add_items(params[:product_id].to_i)
    redirect_to products_path
    
    rescue ActiveRecord::RecordNotFound 
      logger.error("Attempt to access invalid product #{params[:id]}") 
      flash[:notice] = "Invalid product" 
      redirect_to products_path
    
  end
  
  def remove_items
    @cart = setup_cart
    @cart.remove_items(params[:product_id].to_i)
    
    if params[:page]
      redirect_to checkout_path
    else
      redirect_to products_path
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to packages_path, :notice => "Your cart is empty"
  end
  
end
