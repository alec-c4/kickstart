require "view_component/test_helpers"

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
end
