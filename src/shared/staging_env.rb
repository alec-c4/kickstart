# Create staging environment based on production
run "cp config/environments/production.rb config/environments/staging.rb"

# Update staging environment configuration
gsub_file "config/environments/staging.rb",
          /Rails\.application\.configure do/,
          "# Staging environment configuration (based on production)\nRails.application.configure do"

gsub_file "config/environments/staging.rb",
          /config\.log_level = :info/,
          "config.log_level = :debug"

# Add staging to database.yml
append_to_file "config/database.yml" do
  <<-YAML

staging:
  primary: &primary_staging
    <<: *default
    database: <%= ENV.fetch("DATABASE_NAME") { "#{app_name}_staging" } %>
    username: <%= ENV.fetch("DATABASE_USERNAME") { "#{app_name}" } %>
    password: <%= ENV["DATABASE_PASSWORD"] %>
  cache:
    <<: *primary_staging
    database: <%= ENV.fetch("DATABASE_NAME") { "#{app_name}_staging_cache" } %>
    migrations_paths: db/cache_migrate
  queue:
    <<: *primary_staging
    database: <%= ENV.fetch("DATABASE_NAME") { "#{app_name}_staging_queue" } %>
    migrations_paths: db/queue_migrate
  cable:
    <<: *primary_staging
    database: <%= ENV.fetch("DATABASE_NAME") { "#{app_name}_staging_cable" } %>
    migrations_paths: db/cable_migrate
  YAML
end

# Add staging to cable.yml if it exists
if File.exist?("config/cable.yml")
  append_to_file "config/cable.yml" do
    <<-YAML

staging:
  adapter: solid_cable
  connects_to:
    database:
      writing: cable
  polling_interval: 0.1.seconds
  message_retention: 1.day
    YAML
  end
end

# Add staging to aws.yml
gsub_file "config/aws.yml",
          /production:\n  <<: \*default/,
          "staging:\n  <<: *default\n\nproduction:\n  <<: *default"
