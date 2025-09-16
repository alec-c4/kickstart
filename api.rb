# frozen_string_literal: true

TEMPLATE_NAME = "api".freeze

#==============================================================================
# SHARED CODE (embedded to avoid require_relative issues with remote loading)
#==============================================================================

# From src/shared/rails_version.rb
require "rails/all"

RAILS_REQUIREMENT = ">= 8.1.0.beta.1"

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

# From src/shared/gemfile_requirement.rb
def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d.\w'"]*)?.*$/, 1]
  req && req.tr("'", %(")).strip.sub(/^,\s*"/, ', "')
end

# From src/shared/repo.rb
REPO_LINK = "https://github.com/alec-c4/kickstart.git"
AVAILABLE_TEMPLATE_NAMES = %w[api minimal esbuild_tailwind].freeze

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
  # Find template root - current directory when running remotely, or same directory when local
  template_root = __FILE__.match?(%r{\Ahttps?://}) ?
    source_paths.first : File.dirname(__FILE__)

  if variant_name
    variant_path = File.join(template_root, "variants", variant_name)
    source_paths.unshift(variant_path) if File.directory?(variant_path)
  end

  # Always add shared variant path
  shared_path = File.join(template_root, "variants", "shared")
  source_paths.unshift(shared_path) if File.directory?(shared_path)
end

# From src/api/post_install_message.rb
def show_post_install_message
  say "\n
  #########################################################################################

  Rails application '#{app_name}' created successfully!

  Next steps:
  $ cd #{app_name}
  $ bundle install
  $ rails db:create db:migrate
  $ bin/dev

  #########################################################################################\n", :green
end

#==============================================================================
# TEMPLATE LOGIC (variants and specific configuration)
#==============================================================================

assert_minimum_rails_version
add_template_repository_to_source_path
set_variant_source_path(TEMPLATE_NAME)

apply "src/shared/general.rb"
apply "src/shared/packages.rb"

after_bundle do
  apply "src/shared/init_generators.rb"
  apply "src/shared/init_db_cli.rb"
  apply "src/shared/init_i18n.rb"

  apply "src/shared/env_rubocop.rb"
  apply "src/shared/migrations_uuid.rb"

  apply "src/shared/gems_rspec.rb"
  apply "src/shared/gems_i18n_tasks.rb"

  apply "src/shared/run_rubocop.rb"
  apply "src/shared/git_init.rb"

  show_post_install_message
end
