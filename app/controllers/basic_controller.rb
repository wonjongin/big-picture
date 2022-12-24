class BasicController < ApplicationController
  include AuthenticateRequest
  # before_action :authenticate_user, :current_user

  def index
    render json: "#{params[:text]}"
  end

  def time
    time_data = {
      "UTC" => Time.now.utc,
      "now" => Time.now
    }
    render json: time_data
  end
end
