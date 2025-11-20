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

# For Inertia templates, layouts will be copied at the end after Inertia generator runs
