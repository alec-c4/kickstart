require "rails_helper"

RSpec.describe "Home", type: :request, inertia: true do
  describe "GET /" do
    it "renders the Home component" do
      get root_path

      expect(response).to have_http_status(:success)
      expect(inertia.component).to eq("Home")
    end

    it "includes shared data in props" do
      get root_path

      expect(inertia).to include_props(
        app_name: MainConfig.app_name
      )
    end

    it "includes flash messages when present" do
      # In Rails, flash persists across one redirect
      # We'll use the env to set flash before the request
      get root_path, env: {
        "action_dispatch.request.flash_hash" => ActionDispatch::Flash::FlashHash.new(notice: "Welcome!")
      }

      expect(inertia).to include_props(
        flash: hash_including(notice: "Welcome!")
      )
    end
  end
end
