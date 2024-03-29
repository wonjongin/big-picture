# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    redirect_uri: ENV['REDIRECT_URI']
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]
