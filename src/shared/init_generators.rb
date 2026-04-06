primary_key_config = options[:database] == "postgresql" ? "\n    g.orm :active_record, primary_key_type: :uuid" : ""

initializer "generators.rb", <<-CODE
  Rails.application.config.generators do |g|#{primary_key_config}
    g.helper false
    g.test_framework :rspec, view_specs: false
  end
CODE
