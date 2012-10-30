class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to dashboard_path
    else
      redirect_to(new_user_session_path, :notice => "Login error. Please try again")
    end
  end

  def destroy
    current_user_session.destroy
    session[:cart] = nil
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end

  def check_session
    if current_admin
      redirect_to root_path
    else
      session[:cart] = nil
      redirect_to new_user_session_path
    end
  end

end
