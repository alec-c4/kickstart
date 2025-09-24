require "rails_helper"

RSpec.describe "Health", type: :request do
  describe "GET /up" do
    it "returns http success" do
      get "/up"
      expect(response).to have_http_status(:success)
    end

    it "returns ok status" do
      get "/up"
      expect(response.body).to eq('<!DOCTYPE html><html><body style="background-color: green"></body></html>')
    end
  end
end