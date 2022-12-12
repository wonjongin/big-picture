class AuthController < ApplicationController
  def google
    user = SocialAuthService.google(omniauth_params)
    payload = { ouid: user.ouid }
    jwt = JsonWebToken.encode payload

    # render json: [user, jwt, omniauth_params]
    render json: []
  end

  def login
    begin
      google_payload = verify_id_token params[:id_token]
      unless google_payload.nil?
        gph = google_payload.to_h
        email = google_payload['email']
        uid = params[:uid]
        provider = params[:provider]
        su = SocialAuth.where(provider: provider, uid: uid).first_or_create do |auth|
          auth.provider = provider
          auth.uid = uid
          auth.email = email
          auth.given_name = gph["given_name"] || gph["name"]
          auth.family_name = gph["family_name"]
          auth.photo = gph["picture"]

          user = User.find_by email: email
            if user.blank?
              ouid = SecureRandom.uuid
              user = User.create email: email, ouid: ouid
              auth.user = user
            end
        end
        user = User.find_by email: email
        payload = { ouid: user.ouid } 
        access_jwt = JsonWebToken.encode payload
        render json: {access_token: access_jwt}
      else
        render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.unauthenticated')]}
      end
      rescue
        render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.unauthenticated')]}
      end
  end

  private

  def omniauth_params
    request.env['omniauth.auth'].to_h
  end

  def verify_id_token(id_token)
    validator = GoogleIDToken::Validator.new
    begin
      payload = validator.check id_token, ENV['GOOGLE_CLIENT_ID']
      payload.to_h
    rescue GoogleIDToken::ValidationError => e
      puts "Cannot validate: #{e}"
      return nil
    end
  end
end
