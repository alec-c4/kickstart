copy_file "config/settings.yml", force: true

inject_into_file "config/application.rb", after: /config\.generators\.system_tests = nil\n/ do
  # the empty line at the beginning of this string is required
  <<-CODE

    # Use settings from config file config/settings.yml
    config.settings = config_for(:settings)
  CODE
end


gsub_file "app/mailers/application_mailer.rb",
          /default from: ".*"/,
          'default from: Rails.configuration.settings.mailer[:email_from]'
