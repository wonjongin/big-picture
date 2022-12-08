module AuthenticateRequest
  extend ActiveSupport::Concern
  require 'json_web_token'

  def authenticate_user
    return render status: :unauthorized, json: { errors: [I18n.t('errors.controllers.auth.unauthenticated')] } unless current_user
  end

  def current_user
    @current_user = nil
    if decoded_token
      data = decoded_token
      user = User.find_by(ouid: data[:ouid])
      if user
        @current_user ||= user
      end
    end
  end

  def decoded_token
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    if header
      begin
        @decoded_token ||= JsonWebToken.decode(header)
      rescue Error => e
        return render json: { errors: [e.message] }, status: :unauthorized
      end
    end
  end
end