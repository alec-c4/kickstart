generate "anyway:install --configs-path=config/settings", force: true
generate "anyway:config main base_url --yml", force: true
generate "anyway:config mailer email_from --yml", force: true

gsub_file "config/main.yml",
          /#  base_url: ".*"/,
          '  base_url: "http://localhost:3000"'

gsub_file "config/mailer.yml",
          /#  email_from: ".*"/,
          '  email_from: "no-reply@example.com"'

gsub_file "app/mailers/application_mailer.rb",
          /default from: ".*"/,
          'default from: MailerConfig.email_from'

if File.exist?("app/views/layouts/application.html.erb")
  inject_into_file "app/views/layouts/application.html.erb", after: /<head>\n/ do
    <<-CODE
    <base href="<%= MainConfig.base_url %>" />
    CODE
  end
end
