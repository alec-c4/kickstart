# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BetterHtml" do
  it "does assert that all .html.erb templates are parseable" do # rubocop:disable RSpec/ExampleLength
    erb_glob = Rails.root.join(
      "app/views/**/{*.htm,*.html,*.htm.erb,*.html.erb,*.html+*.erb}"
    )

    Dir[erb_glob].each do |filename|
      data = File.read(filename)
      expect {
        BetterHtml::BetterErb::ErubiImplementation.new(data, filename:).validate!
      }.not_to raise_exception
    end
  end
end
