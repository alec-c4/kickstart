copy_file "config/settings/lockbox_config.rb", force: true

initializer "lockbox.rb", <<-CODE
  Lockbox.master_key = LockboxConfig.master_key
CODE
