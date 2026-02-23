# frozen_string_literal: true

say "🌐 Integrating inertia_i18n for Inertia.js frontend...", :magenta

after_bundle do
  # Run the generator
  generate "inertia_i18n:install"

  create_file "app/frontend/locales/en.json", "{}\n"
  create_file "app/frontend/locales/ru.json", "{}\n"

  say "✓ inertia_i18n integration complete", :green
  say "  Run 'bundle exec rake inertia_i18n:convert' to sync YAML to JSON", :blue
end
