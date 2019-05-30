class ApplicationController < ActionController::Base

  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :set_locale
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def require_admin_privileges
    redirect_to root_path unless admin_signed_in?
  end

end
