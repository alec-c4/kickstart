# Configure RSpec for Inertia Rails testing
# Inject the inertia_rails/rspec require into rails_helper.rb

inject_into_file "spec/rails_helper.rb", after: "require 'rspec/rails'\n" do
  "require 'inertia_rails/rspec'\n"
end

copy_file "spec/requests/home_spec.rb", force: true

say "✓ Inertia RSpec configuration added", :green
