class AuthenticationController < ApplicationController
  def destroy
    session[:authentication] = nil
    redirect_to root_path
  end
end
