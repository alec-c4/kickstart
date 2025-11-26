require "rails_helper"

RSpec.describe "Pages", type: :request, inertia: true do
  describe "GET /terms" do
    it "returns http success" do
      get "/terms"
      expect(response).to have_http_status(:success)
    end

    it "renders the Terms component" do
      get "/terms"
      expect(inertia.component).to eq("Terms")
    end
  end

  describe "GET /privacy" do
    it "returns http success" do
      get "/privacy"
      expect(response).to have_http_status(:success)
    end

    it "renders the Privacy component" do
      get "/privacy"
      expect(inertia.component).to eq("Privacy")
    end
  end
end
