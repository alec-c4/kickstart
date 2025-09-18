copy_file "spec/better_html_spec.rb", force: true
copy_file "app/helpers/application_helper.rb", force: true

initializer "better_html.rb", <<-CODE
  BetterHtml.configure do |config|
    config.template_exclusion_filter = proc { |filename| !filename.start_with?(Rails.root.to_s) }
    config.partial_tag_name_pattern = /\\A[a-zA-Z0-9\\-:]+\\z/
  end
CODE
