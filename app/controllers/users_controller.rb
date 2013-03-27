class UsersController < ApplicationController
  
  before_filter :require_admin, except: [:show]
  before_filter :require_auth, only: [:show]
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @users }
    end
  end

  def show
    respond_to do |format|      
      format.html { render layout: 'internal'}
      format.json  { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json  { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if current_user = @user && @user.update_attributes(params[:user])
        format.html { redirect_to(@user, notice: 'User was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { redirect_to :back, notice: "Processing Error. Please try again."}
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_dashboard_path) }
      format.json  { head :ok }
    end
  end
end
