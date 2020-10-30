Rails.application.config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
    g.stylesheets false
    g.javascripts false
    g.helper false
    g.assets false
    g.channel assets: false
    g.system_tests nil
  end
  