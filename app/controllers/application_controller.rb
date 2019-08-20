class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :logged_in_user
  
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t(:request_login)
    redirect_to login_path
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def set_locale
    # I18n.locale = params[:locale] || I18n.default_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
