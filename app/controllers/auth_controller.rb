class AuthController < ApplicationController
  def google
    user = SocialAuthService.google(omniauth_params)
    render json: [user, omniauth_params]
  end

  private
  def omniauth_params
    request.env['omniauth.auth'].to_h
  end
end
