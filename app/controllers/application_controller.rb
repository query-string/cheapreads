class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_authentication

  def current_authentication
    @current_authentication ||= session[:authentication].present? ? Authentication.find(session[:authentication][:id]) : nil
  end
end
