# Run Inertia Rails generator with Vue
# Generator will install Vite automatically and modify application.html.erb
# Options:
# --framework=vue - Use Vue 3 for UI
# --typescript - Enable TypeScript support
# --no-interactive - Skip interactive prompts
# --tailwind - Install and configure Tailwind CSS
# --vite - Use Vite for bundling
# --no-example-page - Skip creating example page (we'll create our own)
# --force - Force overwrite bin/dev and other files
rails_command "generate inertia:install --framework=vue --typescript --no-interactive --tailwind --vite --no-example-page --force"

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
        }
      }
    end
  end
end
RUBY

# Update ApplicationController to include InertiaShare
inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
  "  include InertiaShare\n"
end

# Copy base layouts and components
directory "app/frontend/layouts", "app/frontend/layouts"
directory "app/frontend/components", "app/frontend/components"
directory "app/frontend/pages", "app/frontend/pages"

# Create home controller and route
create_file "app/controllers/home_controller.rb", <<-RUBY
class HomeController < ApplicationController
  def index
    render inertia: "Home"
  end
end
RUBY

route "root 'home#index'"
