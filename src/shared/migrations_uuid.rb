generate "migration EnableUuidPsqlExtension"
uuid_migration_file = (Dir["db/migrate/*_enable_uuid_psql_extension.rb"]).first
copy_file "migrations/uuid.rb", uuid_migration_file, force: true
