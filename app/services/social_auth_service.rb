# frozen_string_literal: true

class SocialAuthService
  def self.google(params)
    apply(params, 'google')
  end

  def self.apply(params, provider)
    return nil unless params["provider"].present? && params["uid"].present? && params["info"].present?
    return nil unless params["provider"].include?(provider)

    social_auth = initialize(params, provider)
    social_auth.user
  end

  def self.initialize(params, provider)
    SocialAuth.where(provider: provider, uid: params["uid"]).first_or_create do |auth|
      auth.provider = provider
      auth.uid = params["uid"]
      auth.email = params["info"]["email"]
      auth.given_name = params["info"]["first_name"] || params["info"]["name"]
      auth.family_name = params["info"]["last_name"]
      auth.photo = params["info"]["image"]

      link_user(auth)
    end
  end

  def self.link_user(auth)
    return if auth.user_id.present?
    ouid = SecureRandom.uuid
    user = User.find_by(email: auth.email)
    user = User.create(email: auth.email, ouid: ouid) if user.blank?
    auth.user = user
  end
end