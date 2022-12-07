class BasicController < ApplicationController
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
