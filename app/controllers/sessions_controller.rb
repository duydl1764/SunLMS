class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t(:invalid_email_or_password)
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
