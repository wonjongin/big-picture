class AuthController < ApplicationController
  def google
    user = SocialAuthService.google(omniauth_params)
    payload = { ouid: user.ouid }
    jwt = JsonWebToken.encode payload

    render json: Rails.env.development? ? [user, jwt, omniauth_params] : []
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
        ts = create_tokens user

        render json: {data: ts}
      else
        render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.unauthenticated')]}
      end
    rescue Error => e
      puts e
      render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.unauthenticated')]}
    end
  end

  def refresh
    refresh_token = params[:refresh_token]
    ts = verify_refresh_token refresh_token
    render json: {data: ts} if ts
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.unauthenticated')]} unless ts
  end

  private

  def omniauth_params
    request.env['omniauth.auth'].to_h
  end

  def create_tokens(user)
    random = SecureRandom.uuid
    payload = { ouid: user.ouid }
    refresh_payload = { uuid: random }
    access_expired_at = ENV['ACCESS_EXPIRE'].to_i.seconds.from_now
    refresh_expired_at = ENV['REFRESH_EXPIRE'].to_i.seconds.from_now
    access_token = JsonWebToken.encode payload, access_expired_at
    refresh_token = JsonWebToken.encode refresh_payload, refresh_expired_at
    t = Token.create do |tt| 
      tt.access_token = access_token
      tt.refresh_token = refresh_token 
      tt.access_expired_at = access_expired_at
      tt.refresh_expired_at = refresh_expired_at
      tt.user = user
    end
    {
      access_token: access_token, 
      refresh_token: refresh_token, 
      access_expired_at: access_expired_at, 
      refresh_expired_at: refresh_expired_at
    }
  end

  def verify_refresh_token(refresh_token)
    t = Token.find_by refresh_token: refresh_token
    return nil unless t
    if Time.at(t.refresh_expired_at) > Time.now
      if Time.at(t.access_expired_at) > Time.now
        t.destroy
        nil
      else
        t.destroy
        create_tokens t.user
      end
    else
      nil
    end
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
