# frozen_string_literal: true

say "🌐 Integrating inertia_i18n for Inertia.js frontend...", :magenta

after_bundle do
  generate "inertia_i18n:install"
  generate "inertia_i18n:test"

  # Sync backend YAML → frontend JSON so translations are in sync from the start
  run "bundle exec rake inertia_i18n:convert"

  say "✓ inertia_i18n integration complete", :green
end
