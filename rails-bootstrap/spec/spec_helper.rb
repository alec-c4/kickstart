require "action_mailer"
require "email_spec"
require "email_spec/rspec"
require "capybara/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before do |example|
    if %i[controller feature].include?(example.metadata[:type])
      request.env["HTTP_ACCEPT_LANGUAGE"] = "en" # ugly solution
    end
  end
end
