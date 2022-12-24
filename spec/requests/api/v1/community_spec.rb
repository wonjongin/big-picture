require 'rails_helper'

RSpec.describe "Api::V1::Communities", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/community/index"
      expect(response).to have_http_status(:success)
    end
  end

end
