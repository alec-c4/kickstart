# Configure generators for Inertia - skip JavaScript, assets, and helpers
primary_key_config = options[:database] == "postgresql" ? "\n      g.orm :active_record, primary_key_type: :uuid" : ""

initializer "generators.rb", <<-CODE
  Rails.application.config.generators do |g|#{primary_key_config}
      g.test_framework :rspec, view_specs: false
      g.assets false
      g.helper false
      g.javascripts false
      g.stylesheets false
  end
CODE
