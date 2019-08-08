class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please login!"
      redirect_to login_path
    end
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
