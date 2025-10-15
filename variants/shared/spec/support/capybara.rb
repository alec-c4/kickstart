require "capybara/rspec"

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers, type: :component
end
