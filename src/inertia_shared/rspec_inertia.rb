# Configure RSpec for Inertia Rails testing
# Inject the inertia_rails/rspec require into rails_helper.rb

inject_into_file "spec/rails_helper.rb", after: "require 'rspec/rails'\n" do
  <<-RUBY
require 'inertia_rails/rspec'
# Load Vite Ruby helpers for test environment (needed for vite_stylesheet_tag, etc.)
require 'vite_ruby'
  RUBY
end

# Copy Inertia request specs
copy_file "spec/requests/landing_spec.rb", force: true
copy_file "spec/requests/pages_spec.rb", force: true

say "✓ Inertia RSpec configuration added", :green
