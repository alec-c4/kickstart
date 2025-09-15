# frozen_string_literal: true

TEMPLATE_NAME = "api".freeze

require_relative "src/shared/rails_version"
require_relative "src/shared/repo"
require_relative "src/shared/gemfile_requirement"
require_relative "src/shared/general"
require_relative "src/shared/packages"
require_relative "src/shared/git_init"
require_relative "src/shared/init_generators"
require_relative "src/shared/init_db_cli"
require_relative "src/shared/init_i18n"
require_relative "src/shared/migrations_uuid"
require_relative "src/shared/env_rubocop"

require_relative "src/shared/gems_rspec"
require_relative "src/shared/gems_i18n_tasks"

require_relative "src/shared/run_rubocop"

require_relative "src/" + TEMPLATE_NAME + "/post_install_message"

assert_minimum_rails_version
add_template_repository_to_source_path
set_variant_source_path(TEMPLATE_NAME)
copy_general_files
setup_packages

after_bundle do
  add_generators
  add_db_cli
  add_i18n_initializer
  setup_rubocop_dev_env
  create_uuid_migration

  setup_rspec_gem
  setup_i18n_tasks_gem

  run_rubocop
  init_git_repo
  show_post_install_message
end
