class Api::V1::UserController < ApplicationController
  include AuthenticateRequest
  before_action :authenticate_user, :current_user

  def me
    puts @current_user
    render json: { data: { email: @current_user.email } }
  end

  def my_logins
    ts = @current_user.tokens.select("id, created_at, user_agent")
    render json: ts
  end
end
