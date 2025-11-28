# frozen_string_literal: true

# Cleanup unnecessary files created by the Inertia Rails generator
#
# The inertia:install generator creates some files that are not needed
# for our Kickstart configuration:
# 1. package-lock.json - we use Yarn, not npm
# 2. app/frontend/entrypoints/application.js - not used with our Vite setup
# 3. app/assets/stylesheets/ - we use Tailwind via Vite, not the asset pipeline

say "Cleaning up unnecessary files created by Inertia generator..."

# Remove package-lock.json if it exists (we use Yarn)
if File.exist?("package-lock.json")
  remove_file "package-lock.json"
  say "  ✓ Removed package-lock.json (using Yarn)", :green
end

# Remove app/frontend/entrypoints/application.js if it exists
# Inertia uses app/frontend/entrypoints/inertia.{js,ts,tsx} instead
application_js_path = "app/frontend/entrypoints/application.js"
if File.exist?(application_js_path)
  remove_file application_js_path
  say "  ✓ Removed #{application_js_path} (not used)", :green
end

# Remove app/assets/stylesheets directory if it exists and is empty or only contains application.css
stylesheets_dir = "app/assets/stylesheets"
if Dir.exist?(stylesheets_dir)
  # Check if directory only contains application.css or is empty
  files = Dir.glob("#{stylesheets_dir}/**/*").select { |f| File.file?(f) }

  if files.empty?
    FileUtils.rm_rf(stylesheets_dir)
    say "  ✓ Removed empty #{stylesheets_dir} directory", :green
  elsif files.size == 1 && files.first.end_with?("application.css")
    # Remove application.css and then the directory
    remove_file files.first
    FileUtils.rm_rf(stylesheets_dir)
    say "  ✓ Removed #{stylesheets_dir} (using Tailwind via Vite)", :green
  end
end

say "Cleanup complete!", :green
