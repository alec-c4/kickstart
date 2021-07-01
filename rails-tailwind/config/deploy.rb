# config valid for current version and patch releases of Capistrano
lock "~> 3.16" # <--- CHANGE IT IF REQUIRED

set :application, "APPLICATION_NAME" # <--- CHANGE IT
set :repo_url, "git@github.com:YOUR_ACCOUNT/APPLICATION_NAME.git" # <--- CHANGE IT

set :deploy_to, "/var/www/#{fetch :application}" # <--- CHANGE IT
set :keep_releases, 5
set :deploy_via, :remote_cache

set :log_level, :info
set :forward_agent, true

set :rbenv_ruby, "3.0.1" # <--- CHANGE IT
set :rbenv_type, :user
set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl webpack]
set :rbenv_roles, :all

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :format, :airbrussh
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

append :linked_files, "config/database.yml", "config/settings.yml", "config/sidekiq.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage", "public/packs",
       ".bundle", "node_modules"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set sidekiq_roles: :app
set sidekiq_default_hooks: true
set sidekiq_pid: File.join(shared_path, "tmp", "pids", "sidekiq.pid") # ensure this path exists in production before deploying.
set sidekiq_env: fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set sidekiq_log: File.join(shared_path, "log", "sidekiq.log")

# sidekiq systemd options
set sidekiq_service_unit_name: "sidekiq"
set sidekiq_service_unit_user: :user # :system
set sidekiq_enable_lingering: true
set sidekiq_lingering_user: nil

task :add_default_hooks do
  after "deploy:starting", "sidekiq:quiet"
  after "deploy:updated", "sidekiq:stop"
  after "deploy:reverted", "sidekiq:stop"
  after "deploy:published", "sidekiq:start"
end

# Disable Sprockets stuff for Webpacker
Rake::Task["deploy:assets:backup_manifest"].clear_actions

before "deploy:assets:precompile", "deploy:yarn_install"
namespace :deploy do
  desc "Run rake yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end
end

### Administration part

namespace :admin do
  desc "Report Uptimes"
  task :uptime do
    on roles(:all) do |host|
      info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
    end
  end

  desc "Add github to ~/.ssh/known_hosts"
  task :friendly_github do
    on roles(:all) do |_host|
      execute "ssh-keyscan", "-t rsa", "-H github.com >> ~/.ssh/known_hosts"
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  desc "Creates initial templates for server-side configs."
  task :setup_configs do
    on roles(:app) do |_host|
      execute "mkdir", "-p #{shared_path}/config" unless test "[ -d #{shared_path}/config ]"

      unless test "[ -f #{shared_path}/config/database.yml ]"
        upload! "config/database.yml", "#{shared_path}/config/database.yml"
      end

      unless test "[ -f #{shared_path}/config/settings.yml ]"
        upload! "config/settings.yml", "#{shared_path}/config/settings.yml"
      end

      unless test "[ -f #{shared_path}/config/master.key ]"
        upload! "config/master.key", "#{shared_path}/config/master.key"
      end

      unless test "[ -f #{shared_path}/config/sidekiq.yml ]"
        upload! "config/sidekiq.yml", "#{shared_path}/config/sidekiq.yml"
      end

      puts "---------------------------------------------------"
      puts "Now edit the config files in #{shared_path}/config."
    end
  end
end
