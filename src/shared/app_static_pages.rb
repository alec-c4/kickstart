copy_file "app/controllers/pages_controller.rb", force: true
copy_file "app/controllers/landing_controller.rb", force: true

copy_file "config/routes/pages.rb", force: true
copy_file "config/routes/landing.rb", force: true
copy_file "spec/requests/pages_spec.rb", force: true
copy_file "spec/requests/landing_spec.rb", force: true
directory "app/views/pages", force: true
directory "app/views/landing", force: true
