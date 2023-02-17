class Api::V1::CommunityController < ApplicationController
  include AuthenticateRequest
  before_action :authenticate_user, :current_user

  def create
    ocid = SecureRandom.uuid
    c = Community.create do |c|
      c.dp_name = params[:name]
      c.ocid = ocid
      c.users << @current_user
    end

    render json: { data: c }
  end

  def my
    render json: { data: @current_user.communities }
  end

  def invite

  end

  private

  def is_a_member_of(user, community)
    if community.users.include? user
      true
    elsif false
    end
  end
end
