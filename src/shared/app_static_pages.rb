generate :controller, "Pages", "home", "about", "terms", "privacy"

gsub_file "app/views/layouts/application.html.erb",
          "<%#= tag.link rel: \"manifest\", href: pwa_manifest_path(format: :json) %>",
          "<%= tag.link rel: \"manifest\", href: pwa_manifest_path(format: :json) %>"

copy_file "config/routes.rb", force: true
copy_file "spec/requests/pages_spec.rb", force: true
directory "config/routes", force: true
directory "app/views/pages", force: true
