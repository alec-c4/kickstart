# Determine framework from template name
framework = case TEMPLATE_NAME
            when "inertia_react" then "react"
            when "inertia_vue" then "vue"
            when "inertia_svelte" then "svelte"
            else
              raise "Unknown Inertia template: #{TEMPLATE_NAME}"
            end

# Run Inertia Rails generator with the appropriate framework
# Generator will install Vite automatically and modify application.html.erb
# Options:
# --framework - Use React/Vue/Svelte for UI
# --typescript - Enable TypeScript support
# --no-interactive - Skip interactive prompts
# --tailwind - Install and configure Tailwind CSS
# --vite - Use Vite for bundling
# --no-example-page - Skip creating example page (we'll create our own)
# --force - Force overwrite bin/dev and other files
rails_command "generate inertia:install --framework=#{framework} --typescript --no-interactive --tailwind --vite --no-example-page --force"

# Fix bin/vite creation - vite_ruby's install command uses deprecated bundler --path flag
# Create the binstub manually using modern bundler syntax
run "bundle binstub vite_ruby"

# Create Inertia controller concern for shared data
create_file "app/controllers/concerns/inertia_share.rb", <<-RUBY
module InertiaShare
  extend ActiveSupport::Concern

  included do
    inertia_share do
      {
        app_name: MainConfig.app_name,
        flash: {
          notice: flash[:notice],
          alert: flash[:alert],
          error: flash[:error]
        }.compact
      }
    end
  end
end
RUBY

# Update ApplicationController to include InertiaShare
inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
  "  include InertiaShare\n"
end

# Copy base layouts, lib (with components), and pages
directory "app/frontend/layouts", "app/frontend/layouts"
directory "app/frontend/lib", "app/frontend/lib"
directory "app/frontend/pages", "app/frontend/pages"

# Create landing controller and route for home page
create_file "app/controllers/landing_controller.rb", <<-RUBY
class LandingController < ApplicationController
  def home
    render inertia: "Home"
  end

  def about
    render inertia: "About"
  end
end
RUBY

# Create pages controller for static pages
create_file "app/controllers/pages_controller.rb", <<-RUBY
class PagesController < ApplicationController
  def terms
    render inertia: "Terms"
  end

  def privacy
    render inertia: "Privacy"
  end
end
RUBY

# Copy routes.rb and route partials (after Inertia generator to avoid overwriting)
copy_file "config/routes.rb", force: true

# Copy individual route files from variants
# Note: directory command doesn't work well with source_paths priority
empty_directory "config/routes"
copy_file "config/routes/landing.rb", force: true
copy_file "config/routes/pages.rb", force: true
copy_file "config/routes/support.rb", force: true

# These files are in inertia_shared (lower priority in source_paths)
# so we need to copy them explicitly from the template source
inside "config/routes" do
  create_file "dev.rb", File.read(File.join(source_paths[1], "config/routes/dev.rb"))
  create_file "errors.rb", File.read(File.join(source_paths[1], "config/routes/errors.rb"))
end

# Configure Inertia Rails
create_file "config/initializers/inertia.rb", <<~RUBY
  # frozen_string_literal: true

  # Inertia Rails Configuration
  # https://inertia-rails.dev

  InertiaRails.configure do |config|
    # Always include errors hash for Inertia protocol compliance (InertiaRails 4.0+)
    config.always_include_errors_hash = true
  end
RUBY

say "✓ Inertia Rails configured with #{framework}", :green
