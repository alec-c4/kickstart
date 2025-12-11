# Finalize layouts after Inertia generator has run
# This ensures we have our custom layout with all necessary tags

say "Finalizing Inertia layouts..."

# Copy our final application layout (with proper Inertia and Vite tags)
copy_file "app/views/layouts/application.html.erb", force: true

# Update tsconfig to add $lib/* path mapping
# React/Vue use tsconfig.app.json, Svelte uses tsconfig.json
tsconfig_file = if File.exist?("tsconfig.app.json")
                  "tsconfig.app.json"
                elsif File.exist?("tsconfig.json")
                  "tsconfig.json"
                end

if tsconfig_file
  inject_into_file tsconfig_file, after: '"paths": {' do
    "\n      \"$lib/*\": [\"app/frontend/lib/*\"],"
  end
  say "✓ Added $lib/* path mapping to #{tsconfig_file}", :green
else
  say "⚠ Warning: tsconfig file not found, skipping $lib/* path mapping", :yellow
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

# Update tsconfig.node.json to include node types
# This allows TypeScript to recognize node modules in vite.config
if File.exist?("tsconfig.node.json")
  inject_into_file "tsconfig.node.json", after: '"noEmit": true' do
    ',
    "types": ["node"]'
  end
  say "✓ Added node types to tsconfig.node.json", :green
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
      'import path from "path"\n'
    end
  end

  # Add resolve.alias config
  inject_into_file vite_config, after: "export default defineConfig({\n" do
    <<~JS
      resolve: {
        alias: {
          "@": path.resolve(__dirname, "./app/frontend"),
          "~": path.resolve(__dirname, "./app/frontend"),
          "$lib": path.resolve(__dirname, "./app/frontend/lib"),
        },
      },
    JS
  end
  say "✓ Added resolve.alias to #{vite_config}", :green
else
  say "⚠ Warning: vite.config not found, skipping alias setup", :yellow
end

say "Layouts finalized with Inertia and Vite configuration"
