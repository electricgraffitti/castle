class UserInteractiveProductsController < ApplicationController
  # GET /user_interactive_products
  # GET /user_interactive_products.json
  def index
    @user_interactive_products = UserInteractiveProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_interactive_products }
    end
  end

  # GET /user_interactive_products/1
  # GET /user_interactive_products/1.json
  def show
    @user_interactive_product = UserInteractiveProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_interactive_product }
    end
  end

  # GET /user_interactive_products/new
  # GET /user_interactive_products/new.json
  def new
    @user_interactive_product = UserInteractiveProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_interactive_product }
    end
  end

  # GET /user_interactive_products/1/edit
  def edit
    @user_interactive_product = UserInteractiveProduct.find(params[:id])
  end

  # POST /user_interactive_products
  # POST /user_interactive_products.json
  def create
    @user_interactive_product = UserInteractiveProduct.new(params[:user_interactive_product])

    respond_to do |format|
      if @user_interactive_product.save
        format.html { redirect_to @user_interactive_product, notice: 'User interactive product was successfully created.' }
        format.json { render json: @user_interactive_product, status: :created, location: @user_interactive_product }
      else
        format.html { render action: "new" }
        format.json { render json: @user_interactive_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_interactive_products/1
  # PUT /user_interactive_products/1.json
  def update
    @user_interactive_product = UserInteractiveProduct.find(params[:id])

    respond_to do |format|
      if @user_interactive_product.update_attributes(params[:user_interactive_product])
        format.html { redirect_to @user_interactive_product, notice: 'User interactive product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_interactive_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_interactive_products/1
  # DELETE /user_interactive_products/1.json
  def destroy
    @user_interactive_product = UserInteractiveProduct.find(params[:id])
    @user_interactive_product.destroy

    respond_to do |format|
      format.html { redirect_to user_interactive_products_url }
      format.json { head :no_content }
    end
  end
end
