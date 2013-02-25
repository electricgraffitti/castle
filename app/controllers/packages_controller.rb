class PackagesController < ApplicationController
  
  before_filter :require_admin, :except => [:index]
  before_filter :require_no_user

  # GET /packages
  # GET /packages.xml
  def index
    @packages = Package.package_order
    @blog = Blog.last

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @packages }
    end
  end

  # GET /packages/1
  # GET /packages/1.xml
  def show
    @package = Package.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @package }
    end
  end

  # GET /packages/new
  # GET /packages/new.xml
  def new
    @package = Package.new
    @package.photos.build
    5.times {@package.packaged_products.build}
    @listings = Package.order.package_order

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @package }
    end
  end

  # GET /packages/1/edit
  def edit
    @package = Package.find(params[:id])
    @listings = Package.order.package_order

    
    if @package.photos.blank?
      @package.photos.build
    end
    
    if @package.packaged_products.blank?
      5.times {@package.packaged_products.build}
    end
    
  end

  # POST /packages
  # POST /packages.xml
  def create
    @package = Package.new(params[:package])

    respond_to do |format|
      if @package.save
        format.html { redirect_to(packages_path, :notice => 'Package was successfully created.') }
        format.xml  { render :xml => @package, :status => :created, :location => @package }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /packages/1
  # PUT /packages/1.xml
  def update
    @package = Package.find(params[:id])

    respond_to do |format|
      if @package.update_attributes(params[:package])
        format.html { redirect_to(packages_path, :notice => 'Package was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.xml
  def destroy
    @package = Package.find(params[:id])
    @package.destroy

    respond_to do |format|
      format.html {redirect_to(admin_dashboard_path, :notice => "Package has been deleted")}
      format.xml  { head :ok }
    end
  end
end
