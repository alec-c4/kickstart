# frozen_string_literal: true

#==============================================================================
# CONSTANTS - Template configuration and shared values
#==============================================================================

REPO_LINK = "https://github.com/alec-c4/kickstart.git"
AVAILABLE_TEMPLATE_NAMES = %w[api importmap_tailwind esbuild_tailwind].freeze
TEMPLATE_NAME = "esbuild_tailwind".freeze
RAILS_REQUIREMENT = ">= 8.1.0.beta.1"

TEMPLATE_METADATA = {
  name: "esbuild_tailwind",
  description: "Rails app with ESBuild and Tailwind CSS for modern frontend development",
  features: %w[postgresql devcontainer rspec rubocop uuid i18n tailwind esbuild turbo stimulus kamal solid_queue solid_cache solid_cable],
  rails_version: RAILS_REQUIREMENT
}.freeze

#==============================================================================
# SHARED CODE - Embedded functions (auto-generated, do not edit manually)
#==============================================================================

require "rails/all"

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d.\w'"]*)?.*$/, 1]
  req && req.tr("'", %(")).strip.sub(/^,\s*"/, ', "')
end

def add_template_repository_to_source_path
  if __FILE__.match?(%r{\Ahttps?://})
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("kickstart-tmp"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      REPO_LINK,
      tempdir
    ].map(&:shellescape).join(" ")

    # Check for specific branch in URL path (e.g., /kickstart/branch_name/template.rb)
    template_pattern = "(?:#{AVAILABLE_TEMPLATE_NAMES.join('|')})"
    if (branch = __FILE__[%r{kickstart/(.+)/#{template_pattern}\.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    # For local files, add the template root directory
    template_root = File.dirname(__FILE__)
    source_paths.unshift(template_root)
  end
end

def set_variant_source_path(variant_name = nil)
  template_root = __FILE__.match?(%r{\Ahttps?://}) ?
    source_paths.first : File.dirname(__FILE__)

  if variant_name
    variant_path = File.join(template_root, "variants", variant_name)
    source_paths.unshift(variant_path) if File.directory?(variant_path)
  end

  shared_path = File.join(template_root, "variants", "shared")
  source_paths.unshift(shared_path) if File.directory?(shared_path)
end

def show_post_install_message
  say "\n
  #########################################################################################

  Rails application '#{app_name}' created successfully!

  Next steps:
  $ cd #{app_name}
  $ bundle install
  $ rails db:create db:migrate
  $ rails parallel:create  # Creates parallel test databases (ignore 'already exists' message)
  $ bin/dev

  #########################################################################################\n", :green
end

#==============================================================================
# TEMPLATE LOGIC - Template-specific configuration and workflow
#==============================================================================

assert_minimum_rails_version
add_template_repository_to_source_path
set_variant_source_path(TEMPLATE_NAME)

apply "src/shared/general.rb"
apply "src/esbuild_tailwind/yarnconfig.rb"
apply "src/shared/packages.rb"

after_bundle do
  apply "src/shared/init_generators.rb"
  apply "src/shared/init_db_cli.rb"
  apply "src/shared/init_i18n.rb"
  apply "src/shared/devcontainer.rb"

  apply "src/shared/app_static_pages.rb"

  apply "src/shared/env_rubocop.rb"
  apply "src/shared/migrations_uuid.rb"

  apply "src/shared/gems_anyway_config.rb"
  apply "src/shared/gems_pagy.rb"
  apply "src/shared/gems_active_interaction.rb"
  apply "src/shared/gems_active_decorator.rb"
  apply "src/shared/gems_rspec.rb"
  apply "src/shared/gems_i18n_tasks.rb"
  apply "src/shared/gems_better_html.rb"
  apply "src/shared/gems_erblint.rb"
  apply "src/shared/gems_lockbox.rb"
  apply "src/shared/gems_shrine.rb"
  apply "src/shared/gems_view_component.rb"
  apply "src/shared/helpers.rb"

  apply "src/shared/run_rubocop.rb"
  apply "src/shared/git_init.rb"

  show_post_install_message
end
