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
