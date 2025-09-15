def add_db_cli
  initializer "database_cli.rb", <<-CODE
    Rails.application.configure do
      if Rails.env.local?
        config.active_record.database_cli = {postgresql: "pgcli"}
      end
    end
  CODE
end
