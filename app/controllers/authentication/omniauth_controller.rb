class Authentication::OmniauthController < ApplicationController
  def create
    request.env["omniauth.auth"]
    render text: "OK"
  end
end
