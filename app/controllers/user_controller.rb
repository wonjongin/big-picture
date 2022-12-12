class UserController < ApplicationController
  include AuthenticateRequest
  before_action :authenticate_user, :current_user

  def me
    puts @current_user
    render json: @current_user
  end
end
