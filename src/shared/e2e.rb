# frozen_string_literal: true

say "🎭 Integrating E2E testing with e2e gem...", :magenta

after_bundle do
  generate "e2e:install"

  run "npx playwright install"

  create_file "spec/e2e/landing_spec.rb", <<~RUBY
    # frozen_string_literal: true

    require "e2e_helper"

    RSpec.describe "Landing", type: :e2e do
      it "works" do
        visit "/"
        expect(page.body).to include("#{app_name}")
      end
    end
  RUBY

  say "✓ E2E integration complete", :green
  say "  Run 'rails g e2e:test YourTest' to generate a new E2E test", :blue
end
