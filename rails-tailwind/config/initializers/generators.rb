Rails.application.config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
    g.stylesheets false
    g.javascripts false
    g.helper false
    g.assets false
    g.channel assets: false
    g.system_tests nil

    g.test_framework :rspec,
      fixtures:         false,
      view_specs:       false,
      helper_specs:     false,
      routing_specs:    false,
      request_specs:    false,
      controller_specs: false           
  end
  