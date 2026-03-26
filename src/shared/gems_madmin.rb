# frozen_string_literal: true

# Madmin installation disabled via generator because it requires a DB connection,
# which is not available during project creation.
# Instead, we manually place the base controller and route file.

copy_file "app/controllers/madmin/application_controller.rb", force: true
copy_file "config/routes/madmin.rb", force: true

route "draw :madmin"
