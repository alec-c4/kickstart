# config valid for current version and patch releases of Capistrano
lock "~> 3.16" # <--- CHANGE IT IF REQUIRED

set :application, "APPLICATION_NAME" # <--- CHANGE IT
set :repo_url, "git@github.com:YOUR_ACCOUNT/APPLICATION_NAME.git" # <--- CHANGE IT

set :deploy_to, "/var/www/#{fetch :application}/#{fetch(:stage) { 'production' }}"
set :deploy_user, "deploy"
set :keep_releases, 5
set :deploy_via, :remote_cache

set :rails_env, -> { fetch(:stage) { "production" } }

set :log_level, :info
set :forward_agent, true

set :rbenv_type, :user
set :rbenv_ruby, "3.0.2" # <--- CHANGE IT
set :rbenv_prefix, "#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl]
set :rbenv_roles, :all

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :format, :airbrussh
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: false

append :linked_files, "config/database.yml", "config/settings.yml",
       "config/sidekiq.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/assets", "public/packs", "storage",
       ".bundle", "node_modules"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :pty, false

set :sidekiq_service_unit_user, :system

set :puma_rackup, -> { File.join(current_path, "config.ru") }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env) { fetch(:rails_env) { "production" } }
set :puma_threads, [0, 16]
set :puma_workers, 1
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true

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

  # Clear existing task so we can replace it rather than "add" to it.
  Rake::Task["deploy:compile_assets"].clear

  desc "Precompile assets locally and then rsync to web servers"
  task :compile_assets do
    on roles(:web) do
      rsync_host = host.to_s

      run_locally do
        with rails_env: :production do
          ## Set your env accordingly.
          execute "bundle exec rails assets:precompile"
        end
        execute "rsync -av --delete ./public/assets/ #{fetch(:deploy_user)}@#{rsync_host}:#{shared_path}/public/assets/"
        execute "rsync -av --delete ./public/packs/ #{fetch(:deploy_user)}@#{rsync_host}:#{shared_path}/public/packs/"
        execute "rm -rf public/assets"
        execute "rm -rf public/packs"
        # execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
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

      info "---------------------------------------------------"
      info "Now edit the config files in #{shared_path}/config."
    end
  end
end

