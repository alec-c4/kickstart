# frozen_string_literal: true

say "🌐 Integrating inertia_i18n for Inertia.js frontend...", :magenta

after_bundle do
  # Run the generator
  generate "inertia_i18n:install"

  say "✓ inertia_i18n integration complete", :green
  say "  Run 'bundle exec rake inertia_i18n:convert' to sync YAML to JSON", :blue
end
