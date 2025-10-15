generate "anyway:install --configs-path=config/settings", force: true
generate "anyway:config main app_name base_url --yml", force: true
generate "anyway:config mailer email_from --yml", force: true

gsub_file "config/settings/application_config.rb",
          /(@instance \|\|= new)/,
          '\1 # rubocop:disable ThreadSafety/ClassInstanceVariable'

gsub_file "config/main.yml",
          /#  app_name: ".*"/,
          "  app_name: \"#{app_name}\""

gsub_file "config/main.yml",
          /#  base_url: ".*"/,
          '  base_url: "http://localhost:3000"'

gsub_file "config/mailer.yml",
          /#  email_from: ".*"/,
          '  email_from: "no-reply@example.com"'

gsub_file "app/mailers/application_mailer.rb",
          /default from: ".*"/,
          'default from: MailerConfig.email_from'
