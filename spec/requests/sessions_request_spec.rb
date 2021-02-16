require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  xdescribe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET /create" do
    it "returns http success" do
      get "/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET /login" do
    it "returns http success" do
      get "/sessions/login"
      expect(response).to have_http_status(:success)
    end
  end
end
