class Authentication::OmniauthController < ApplicationController
  def create
    omniauth       = request.env["omniauth.auth"]
    authentication = Authentication.with_uid(omniauth.uid)

    if authentication.any?
      session[:authentication] = authentication.first
      redirect_to root_path
    else
    end

    #authenntication = Authentication.new(provider: omniauth.provider, uid: omniauth.uid, secret: omniauth.credentials.secret, token: omniauth.credentials.token)
    #
    #notice = if authenntication.save
    #  "Succesfully created"
    #else
    #  "Something went wrong..."
    #end
    #
    #render plain: notice
  end
end
