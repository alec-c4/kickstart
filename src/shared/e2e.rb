# frozen_string_literal: true

say "🎭 Integrating E2E testing with e2e gem...", :magenta

after_bundle do
  # Run the generator
  generate "e2e:install"

  # Install playwright browsers
  run "npx playwright install"

  say "✓ E2E integration complete", :green
  say "  Run 'rails g e2e:test YourTest' to generate a new E2E test", :blue
end
