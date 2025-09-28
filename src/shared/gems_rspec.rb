generate "rspec:install"

directory "spec", force: true
copy_file ".rspec", force: true

copy_file "spec/requests/health_spec.rb", force: true
copy_file "lib/tasks/factory_bot.rake", force: true
