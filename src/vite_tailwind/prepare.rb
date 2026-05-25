# Copy vite.json before bundle install hooks that run `rails generate`.
# vite_rails loads this config during generator commands; without it, migrations fail.
copy_file "config/vite.json", force: true
