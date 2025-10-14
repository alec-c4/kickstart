generate "rspec:install"

directory "spec", force: true
copy_file ".rspec", force: true

copy_file "spec/requests/health_spec.rb", force: true
copy_file "lib/tasks/factory_bot.rake", force: true

# Enable parallel_tests support in database.yml
gsub_file "config/database.yml",
          /(test:.*?database: \w+)(_test)/m,
          "\\1\\2<%= ENV['TEST_ENV_NUMBER'] %>"
