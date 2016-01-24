class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_authentication

  def current_authentication
    session[:authentication].present? ? OpenStruct.new(session[:authentication]) : nil
  end
end
