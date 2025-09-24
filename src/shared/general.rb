copy_file ".editorconfig", force: true
template "README.md", force: true
copy_file ".gitignore", force: true
copy_file "mise.toml", force: true
copy_file "lefthook.yml", force: true

copy_file ".rubocop.yml", force: true
copy_file ".rubocop_rails.yml", force: true
copy_file ".rubocop_rspec.yml", force: true
copy_file ".rubocop_strict.yml", force: true
copy_file ".rubocop_todo.yml", force: true

layout_file = "app/views/layouts/application.html.erb"
if File.exist?(layout_file)
  gsub_file layout_file,
            /<html>/,
            '<html lang="<%= I18n.locale.to_s %>">'
end
