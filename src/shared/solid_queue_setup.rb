# Replace default database.yml with multi-database configuration
template "config/database.yml.tt", "config/database.yml", force: true

# Add solid_queue configuration to development.rb
inject_into_file "config/environments/development.rb", before: /^end\s*$/ do
  <<-RUBY

  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = {database: {writing: :queue}}
  RUBY
end

# Add jobs process to Procfile.dev if it exists
if File.exist?("Procfile.dev")
  append_to_file "Procfile.dev" do
    "jobs: bin/jobs start\n"
  end
end
