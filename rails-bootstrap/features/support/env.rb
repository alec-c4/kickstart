require "cucumber/rails"
require "email_spec/cucumber"

# frozen_string_literal: true

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, headers: {"HTTP_ACCEPT_LANGUAGE" => "en"})
end

World(FactoryBot::Syntax::Methods)

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation
