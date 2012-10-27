class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      session[:email]   = params[:login]
      redirect_to_target_or_default tasks_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:email]   = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
