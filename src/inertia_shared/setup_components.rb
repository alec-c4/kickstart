# Setup i18n for Inertia frontend based on framework
framework = case TEMPLATE_NAME
            when "inertia_react" then "react"
            when "inertia_vue" then "vue"
            when "inertia_svelte" then "svelte"
            else
              raise "Unknown Inertia template: #{TEMPLATE_NAME}"
            end

say "Setting up components and dark mode for #{framework}...", :blue

# i18n is now handled by inertia_i18n gem
# Dark mode support is integrated in finalized layouts

say "✓ Component setup complete for #{framework}", :green
