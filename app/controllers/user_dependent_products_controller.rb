class UserDependentProductsController < ApplicationController

  before_filter :require_user

  def index
    @user_dependent_products = UserDependentProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_dependent_products }
    end
  end

  def show
    @user_dependent_product = UserDependentProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_dependent_product }
    end
  end

  def new
    @user_dependent_product = UserDependentProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_dependent_product }
    end
  end

  def edit
    @user_dependent_product = UserDependentProduct.find(params[:id])
  end

  def create
    @user_dependent_product = UserDependentProduct.new(params[:user_dependent_product])

    respond_to do |format|
      if @user_dependent_product.save
        format.html { redirect_to @user_dependent_product, notice: 'User dependent product was successfully created.' }
        format.json { render json: @user_dependent_product, status: :created, location: @user_dependent_product }
      else
        format.html { render action: "new" }
        format.json { render json: @user_dependent_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_dependent_product = UserDependentProduct.find(params[:id])

    respond_to do |format|
      if @user_dependent_product.update_attributes(params[:user_dependent_product])
        format.html { redirect_to @user_dependent_product, notice: 'User dependent product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_dependent_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_dependent_product = UserDependentProduct.find(params[:id])
    @user_dependent_product.destroy

    respond_to do |format|
      format.html { redirect_to user_dependent_products_url }
      format.json { head :no_content }
    end
  end
end
