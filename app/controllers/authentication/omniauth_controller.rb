class Authentication::OmniauthController < ApplicationController
  def create
    omniauth       = request.env["omniauth.auth"]
    authentication = Authentication.with_uid(omniauth.uid)

    if authentication.any?
      session[:authentication] = authentication.first
      redirect_to root_path
    else
      create_authentication
    end

  end

  private

  def create_authentication
    authentication = Authentication.new(provider: omniauth.provider, uid: omniauth.uid, secret: omniauth.credentials.secret, token: omniauth.credentials.token)
    notice         = authentication.save ? "Succesfully created" : "Something went wrong..."

    redirect_to root_path, flash: {notice: notice}
  end
end
