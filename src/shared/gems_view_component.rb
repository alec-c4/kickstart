initializer "view_component.rb", <<-CODE
  Rails.application.config.view_component.previews.paths << Rails.root.join("spec/components/previews").to_s
  Rails.application.config.view_component.default_preview_layout = "component_preview"
  Rails.application.config.view_component.generate.sidecar = true
CODE

copy_file "app/helpers/view_component_helper.rb", force: true
copy_file "app/views/layouts/component_preview.html.erb", force: true
