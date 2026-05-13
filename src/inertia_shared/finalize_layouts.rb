# Finalize layouts after Inertia generator has run
# This ensures we have our custom layout with all necessary tags

say "Finalizing Inertia layouts..."

# Copy our final application layout (with proper Inertia and Vite tags)
copy_file "app/views/layouts/application.html.erb", force: true

# Copy Tailwind config with dark mode support
copy_file "tailwind.config.js", force: true
say "✓ Copied Tailwind config with dark mode support", :green

# Copy backend locale files
copy_file "config/locales/en.yml", force: true
copy_file "config/locales/ru.yml", force: true
say "✓ Copied backend locale files (en.yml, ru.yml)", :green

# Copy i18n-tasks configuration
copy_file "config/i18n-tasks.yml", force: true
say "✓ Copied i18n-tasks configuration", :green

# Copy inertia entrypoint with i18n setup
framework_extension = case TEMPLATE_NAME
                      when "inertia_react" then "tsx"
                      when "inertia_vue", "inertia_svelte" then "ts"
                      else "ts"
                      end

copy_file "app/frontend/entrypoints/inertia.#{framework_extension}", force: true
say "✓ Copied Inertia entrypoint with i18n setup", :green

# Normalize compilerOptions.paths: inertia-rails already defines @/* and ~/* with
# "./app/frontend/*". Replace the whole block so we get a single pair without ./
# (injecting after "paths": { duplicated @/*).
# React/Vue use tsconfig.app.json, Svelte uses tsconfig.json
tsconfig_file = if File.exist?("tsconfig.app.json")
                  "tsconfig.app.json"
                elsif File.exist?("tsconfig.json")
                  "tsconfig.json"
                end

if tsconfig_file
  tsconfig_path = tsconfig_file
  content = File.read(tsconfig_path)
  if content.match?(/^([ \t]*)("paths":\s*\{[^}]*\})/m)
    content.sub!(/^([ \t]*)("paths":\s*\{[^}]*\})/m) do
      indent = Regexp.last_match(1)
      inner = "#{indent}  "
      "#{indent}\"paths\": {\n#{inner}\"@/*\": [\"app/frontend/*\"],\n#{inner}\"~/*\": [\"app/frontend/*\"]\n#{indent}}"
    end
    File.write(tsconfig_path, content)
    say "✓ Set @/* and ~/* path mapping in #{tsconfig_file}", :green
  else
    say "⚠ Warning: no paths block in #{tsconfig_file}, skipping path mapping", :yellow
  end
else
  say "⚠ Warning: tsconfig file not found, skipping path mapping", :yellow
end

# Install @types/node for TypeScript support in vite.config
# This provides type definitions for path, __dirname, etc.
run "yarn add -D @types/node"

# Set package.json type to module for ES modules support
# Svelte generator doesn't add these fields, so we add them after yarn install
if File.exist?("package.json")
  require "json"
  package_json_path = "package.json"
  package_data = JSON.parse(File.read(package_json_path))

  needs_update = false

  # Add "private": true if not present
  unless package_data.key?("private")
    package_data["private"] = true
    needs_update = true
    say "✓ Adding private: true to package.json", :green
  end

  # Add "type": "module" if not present
  unless package_data.key?("type")
    package_data["type"] = "module"
    needs_update = true
    say "✓ Adding type: module to package.json", :green
  end

  if needs_update
    # Write back to file, preserving JSON format
    File.write(package_json_path, JSON.pretty_generate(package_data) + "\n")
    say "✓ Updated package.json", :green
  end
end

# Fix tsconfig.node.json: remove "noEmit": true (conflicts with "composite": true when used
# as a project reference — composite projects must be able to emit) and add node types.
if File.exist?("tsconfig.node.json")
  gsub_file "tsconfig.node.json", '"noEmit": true', '"types": ["node"]'
  say "✓ Fixed tsconfig.node.json (replaced noEmit with node types)", :green
end

# Update vite.config to add resolve.alias for runtime resolution
# This is needed for Vite to resolve the paths correctly
vite_config = if File.exist?("vite.config.ts")
                "vite.config.ts"
              elsif File.exist?("vite.config.mts")
                "vite.config.mts"
              end

if vite_config
  is_mts = vite_config.end_with?(".mts")

  # Add imports at the top
  if is_mts
    # For ES modules (.mts), need to define __dirname
    inject_into_file vite_config, after: "import RubyPlugin from 'vite-plugin-ruby'\n" do
      <<~JS
        import path from "path";
        import { fileURLToPath } from "url";

        const __dirname = path.dirname(fileURLToPath(import.meta.url));
      JS
    end
  else
    # For regular .ts files
    inject_into_file vite_config, after: "import RubyPlugin from 'vite-plugin-ruby'\n" do
      "import path from \"path\"\n"
    end
  end

  # Add resolve.alias config
  inject_into_file vite_config, after: "export default defineConfig({\n" do
    <<~JS
      resolve: {
        alias: {
          "@": path.resolve(__dirname, "./app/frontend"),
        },
      },
    JS
  end
  say "✓ Added resolve.alias to #{vite_config}", :green
else
  say "⚠ Warning: vite.config not found, skipping alias setup", :yellow
end

# Update application.css to support dark mode
apply "#{__dir__}/update_application_css.rb"

say "Layouts finalized with Inertia and Vite configuration"
