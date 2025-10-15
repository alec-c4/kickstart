generate "rspec:install"

# Copy only common spec files (not spec/components and spec/requests)
copy_file ".rspec", force: true
copy_file "spec/rails_helper.rb", force: true
copy_file "spec/spec_helper.rb", force: true
copy_file "spec/support/database_cleaner.rb", force: true
copy_file "spec/support/factory_bot.rb", force: true
copy_file "spec/support/shoulda.rb", force: true
copy_file "spec/support/time_helpers.rb", force: true
copy_file "spec/requests/health_spec.rb", force: true
copy_file "lib/tasks/factory_bot.rake", force: true

# Enable parallel_tests support in database.yml
gsub_file "config/database.yml",
          /(test:.*?database: \w+)(_test)/m,
          "\\1\\2<%= ENV['TEST_ENV_NUMBER'] %>"
