copy_file "app/controllers/errors_controller.rb", force: true
directory "app/views/errors", force: true
copy_file "config/routes/errors.rb", force: true

inject_into_file "config/application.rb", after: "config.generators.system_tests = nil\n" do
  <<-RUBY

    # Use custom error pages
    config.exceptions_app = routes
  RUBY
end

# Configure development environment to optionally use custom error pages
gsub_file "config/environments/development.rb",
          /config\.consider_all_requests_local\s*=\s*.+$/,
          'config.consider_all_requests_local = !Rails.root.join("tmp/errors-dev.txt").exist? # Toggle with: rails dev:errors'

# Create rake task to toggle error pages in development
create_file "lib/tasks/dev.rake", <<~RUBY
  # frozen_string_literal: true

  namespace :dev do
    desc "Toggle custom error pages in development"
    task :errors do
      error_file = Rails.root.join("tmp/errors-dev.txt")

      if error_file.exist?
        error_file.delete
        puts "Custom error pages disabled. Restart the server."
      else
        error_file.write("")
        puts "Custom error pages enabled. Restart the server."
      end
    end
  end
RUBY
