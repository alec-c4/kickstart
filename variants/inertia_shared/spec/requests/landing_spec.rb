require "rails_helper"

RSpec.describe "Landing", type: :request, inertia: true do
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "renders the Home component" do
      get "/"
      expect(inertia.component).to eq("Home")
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/about"
      expect(response).to have_http_status(:success)
    end

    it "renders the About component" do
      get "/about"
      expect(inertia.component).to eq("About")
    end
  end
end
