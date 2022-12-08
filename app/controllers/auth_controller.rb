class AuthController < ApplicationController
  def google
    user = SocialAuthService.google(omniauth_params)
    payload = { ouid: user.ouid }
    jwt = JsonWebToken.encode payload

    render json: [user, jwt, omniauth_params]
  end

  private

  def omniauth_params
    request.env['omniauth.auth'].to_h
  end
end
