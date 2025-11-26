initializer "view_component.rb", <<-CODE
  Rails.application.config.view_component.previews.paths << Rails.root.join("spec/components/previews").to_s
  Rails.application.config.view_component.default_preview_layout = "component_preview"
  Rails.application.config.view_component.generate.sidecar = true
CODE

# Create or overwrite inflections.rb initializer
inflections_file = "config/initializers/inflections.rb"
remove_file inflections_file if File.exist?(inflections_file)
initializer "inflections.rb", <<-CODE
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym "UI"
end
CODE

copy_file "app/helpers/view_component_helper.rb", force: true
copy_file "app/views/layouts/component_preview.html.erb", force: true

directory "app/components", force: true
directory "spec/components", force: true

# Copy view component support files for RSpec
copy_file "spec/support/view_component.rb", force: true
copy_file "spec/support/capybara.rb", force: true
