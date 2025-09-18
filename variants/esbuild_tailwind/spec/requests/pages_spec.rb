require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /terms" do
    it "returns http success" do
      get "/pages/terms"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /privacy" do
    it "returns http success" do
      get "/pages/privacy"
      expect(response).to have_http_status(:success)
    end
  end
end
