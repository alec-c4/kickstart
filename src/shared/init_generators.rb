def add_generators
  initializer "generators.rb", <<-CODE
    Rails.application.config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.helper false
      g.test_framework :rspec, view_specs: false
    end
  CODE
end
