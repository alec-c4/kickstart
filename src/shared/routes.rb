empty_directory "config/routes"

copy_file "config/routes/dev.rb", force: true
copy_file "config/routes/support.rb", force: true
copy_file "config/routes.rb", force: true
