def setup_rspec_gem
  generate "rspec:install"

  directory "spec", force: true
  copy_file ".rspec", force: true
end
