# Configure generators for Inertia - skip JavaScript, assets, and helpers
application do
  <<-RUBY
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :rspec, view_specs: false
      g.assets false
      g.helper false
      g.javascripts false
      g.stylesheets false
    end
  RUBY
end
