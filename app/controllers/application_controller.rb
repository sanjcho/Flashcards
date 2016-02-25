class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = 
      if current_user
        current_user.locale
      elsif  I18n.available_locales.map(&:to_s).include?(params[:locale])
        session[:locale] = params[:locale]
      elsif session[:locale]
        session[:locale]
      else
        http_accept_language.compatible_language_from(I18n.available_locales)
      end
  end
end
