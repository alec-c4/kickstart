require 'rails/all'

RAILS_REQUIREMENT = ">= 6.0.3"

def apply_template!
  assert_minimum_rails_version
  source_paths

  setup_vscode
  setup_git

  setup_gemfile

  after_bundle do
    setup_generators
    setup_js_packages
    setup_webpacker
    setup_procfile
    setup_sidekiq

    setup_gems
    setup_migrations
    setup_active_storage
    setup_tailwind
    setup_i18n
    setup_tests
    setup_devise
    setup_user_tools
    setup_pagy

    setup_dev_test
    setup_basic_logic

    setup_rubocop
    run_rubocop

    say
    say "        App successfully created!", :blue
    say
    say "To get started with your new app:", :green
    say "  cd #{app_name}"
    say
    say "  1. # Update config/database.yml with your database credentials"
    say
    say "  $ rails db:create && rails db:migrate"
    say
    say "  2. Configure credentials with"
    say
    say "   $ rails credentials:edit --environment development"
    say "   for development environment"
    say
    say "   $ rails credentials:edit --environment test"
    say "   for test environment"  
    say
    say "   $ rails credentials:edit"
    say "   for production environment"    
    say
    say "   And add data from credentials.example file"
  end
end

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d\.\w'"]*)?.*$/, 1]
  req && req.gsub("'", %(")).strip.sub(/^,\s*"/, ', "')
end

def setup_vscode
  copy_file '.editorconfig', force: true  
  directory '.vscode', force: true  
end

def setup_git
  copy_file '.gitignore', force: true  
end

def setup_gemfile
  template "Gemfile.tt", force: true  
end

def setup_generators
  copy_file 'config/initializers/generators.rb', force: true  
end

def setup_js_packages
  run 'yarn add -D @types/webpack-env'
  run 'yarn add jstz tailwindcss @fullhuman/postcss-purgecss'
end

def setup_webpacker
  run 'rm -rf app/assets'
  run 'mv app/javascript app/frontend'
  gsub_file "config/webpacker.yml", /source_path: app\/javascript/, 'source_path: app/frontend'
  rails_command 'webpacker:install:typescript'
  remove_file 'app/frontend/packs/hello_typescript.ts'
  remove_file 'app/frontend/packs/application.js'
  copy_file 'app/frontend/packs/application.ts'
  run 'mkdir app/frontend/stylesheets'
  run 'mkdir app/frontend/javascripts'
  run 'mkdir app/frontend/images'
  run  'touch app/frontend/images/.keep'
  copy_file 'app/frontend/stylesheets/application.scss', force: true
  copy_file 'app/frontend/javascripts/timezone.ts', force: true
  copy_file 'app/frontend/javascripts/current_year.ts', force: true
end

def setup_procfile
  copy_file '.env', force: true  
  copy_file 'Procfile.dev', force: true  
end

def setup_sidekiq
  copy_file 'config/initializers/sidekiq.rb', force: true  
  copy_file 'config/sidekiq.yml', force: true  
end

def setup_dev_test
  insert_into_file 'config/environments/development.rb', after: /config\.file_watcher = ActiveSupport::EventedFileUpdateChecker\n/ do
    <<-RUBY

    config.action_mailer.default_url_options = {host: "localhost", port: 5000}
    # config.action_mailer.delivery_method = :mailgun
    # config.action_mailer.mailgun_settings = {
    #   api_key: Rails.application.credentials.mailgun[:api_key],
    #   domain: Rails.application.credentials.mailgun[:domain]
    # }
  
    config.after_initialize do
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.growl         = false
      Bullet.rails_logger = true
      Bullet.add_footer = true
    end
    RUBY
  end

  insert_into_file 'config/environments/test.rb', after: /config\.action_view\.raise_on_missing_translations = true\n/ do
    <<-RUBY

    config.action_mailer.default_url_options = {host: "localhost", port: 5000}
    # config.action_mailer.delivery_method = :mailgun
    # config.action_mailer.mailgun_settings = {
    #   api_key: Rails.application.credentials.mailgun[:api_key],
    #   domain: Rails.application.credentials.mailgun[:domain]
    # }
  
    config.after_initialize do
      Bullet.enable = true
      Bullet.bullet_logger = true
      Bullet.raise = true # raise an error if n+1 query occurs
    end
    RUBY
  end 
end

def setup_basic_logic
  copy_file 'config/routes.rb', force: true

  copy_file 'app/controllers/application_controller.rb', force: true

  copy_file 'app/helpers/flash_helper.rb', force: true
  copy_file 'app/views/layouts/_flash.html.erb', force: true

  copy_file 'app/views/layouts/_account_items.html.erb', force: true

  gsub_file 'app/views/layouts/application.html.erb', /<%= yield %>/ do
    <<-LAYOUT
  <header>
      <%= render partial: 'layouts/account_items' %>
      </header>

      <main class="container">
        <%= render partial: 'layouts/flash' %>
        <%= yield %>
      </main>

      <footer class="footer">
        <div class="container mt-5">
          &copy; <span id="current_year"></span>, All rights reserved.
        </div>
      </footer>    
    LAYOUT
  end

  gsub_file 'app/views/layouts/application.html.erb', /stylesheet_link_tag/, 'stylesheet_pack_tag'

  # Home page
  copy_file 'app/controllers/pages_controller.rb', force: true
  copy_file 'app/views/pages/home.html.erb', force: true

  # Customer controller
  copy_file 'app/controllers/customer_controller.rb', force: true

  # Admin controller
  copy_file 'app/controllers/admin_controller.rb', force: true

  # Customer dashboard
  copy_file 'app/controllers/customer/dashboard_controller.rb', force: true
  copy_file 'app/views/customer/dashboard/index.html.erb', force: true

  # Admin dashboard
  copy_file 'app/controllers/admin/dashboard_controller.rb', force: true
  copy_file 'app/views/admin/dashboard/index.html.erb', force: true
end

def setup_gems
  generate 'config:install -s'
end

def setup_migrations
  generate 'migration EnableUuidPsqlExtension'
  uuid_migration_file = (Dir['db/migrate/*_enable_uuid_psql_extension.rb']).first

  in_root { inject_into_file uuid_migration_file, 
        "\nenable_extension \"pgcrypto\"
        \nenable_extension \"uuid-ossp\"", after: "def change" }

end

def setup_active_storage
  rails_command 'active_storage:install'

  as_migration_file = (Dir['db/migrate/*_create_active_storage_tables.active_storage.rb']).first

  in_root { 
    gsub_file as_migration_file, /create_table :active_storage_blobs/, "create_table :active_storage_blobs, id: :uuid"
    gsub_file as_migration_file, /create_table :active_storage_attachments/, "create_table :active_storage_attachments, id: :uuid"

    gsub_file as_migration_file, /t\.references :record,(\s)* null: false, polymorphic: true, index: false/, "t.references :record, null: false, polymorphic: true, index: false, type: :uuid"
    gsub_file as_migration_file, /t\.references :blob,(\s)* null: false/, "t.references :blob, null: false, type: :uuid"
  }
end

def setup_i18n
  copy_file 'config/initializers/i18n.rb', force: true
  directory 'config/locales', force: true
  copy_file 'config/i18n-tasks.yml', force: true
  run 'i18n-tasks normalize'
end

def setup_devise
  generate 'devise:install'
  generate 'devise User'

  devise_migration_file = (Dir['db/migrate/*_devise_create_users.rb']).first

  uncomment_lines devise_migration_file, /add_index/
  uncomment_lines devise_migration_file, /t\.(integer|datetime|inet|string)/

  in_root { inject_into_file devise_migration_file, 
        "\n## Profile
        t.string :first_name
        t.string :last_name
        t.string :gender
        t.date :birthday

        ## Settings
        t.string :time_zone", after: "t.datetime :locked_at" }

  directory 'app/views/devise', force: true
  copy_file 'app/models/user.rb', force: true
end

def setup_pundit
  generate 'pundit:install'
end

def setup_user_tools
  directory 'app/controllers/users', force: true
  directory 'app/views/users', force: true
end

def setup_tailwind
  copy_file 'tailwind.config.js', force: true
  copy_file 'postcss.config.js', force: true
end

def setup_tests
  generate 'rspec:install'
  generate 'cucumber:install'
  run 'cp $(i18n-tasks gem-path)/templates/rspec/i18n_spec.rb spec/'
  directory 'spec', force: true
  directory 'features', force: true
end

def setup_pagy
  copy_file 'config/initializers/pagy.rb', force: true  
  copy_file 'app/helpers/application_helper.rb', force: true  
  copy_file 'app/frontend/stylesheets/pagy.scss', force: true
end

def setup_rubocop
  copy_file '.rubocop.yml', force: true  
  copy_file '.rubocop_todo.yml', force: true  
  copy_file '.rubocop_rails.yml', force: true  
  copy_file '.rubocop_rspec.yml', force: true  
  copy_file '.rubocop_strict.yml', force: true  
end

def run_rubocop
  run 'bundle exec rubocop -a'
end

apply_template!