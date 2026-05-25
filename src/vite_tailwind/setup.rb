require "json"

# yarn set version stable creates package.json without "type": "module".
# vite install renames vite.config.ts -> vite.config.mts when that field is missing,
# so we add it upfront to keep a consistent .ts extension.
if File.exist?("package.json")
  pkg = JSON.parse(File.read("package.json"))
  unless pkg["type"] == "module"
    pkg["type"] = "module"
    File.write("package.json", JSON.pretty_generate(pkg) + "\n")
  end
end

# Install vite_rails: creates bin/vite, config/vite.json, vite.config.ts, Procfile.dev entry
run "bundle exec vite install"

# Patch the generated vite.config.ts in place — add Tailwind CSS v4 plugin
inject_into_file "vite.config.ts", after: "import RubyPlugin from 'vite-plugin-ruby'\n" do
  "import tailwindcss from '@tailwindcss/vite'\n"
end

inject_into_file "vite.config.ts", after: "    RubyPlugin(),\n" do
  "    tailwindcss(),\n"
end

# Replace the sample application.js with a TypeScript entry point
remove_file "app/frontend/entrypoints/application.js"
create_file "app/frontend/entrypoints/application.ts", <<~TS
  import "@hotwired/turbo-rails";
  import "../controllers";
TS

# Stimulus controller registry
empty_directory "app/frontend/controllers"
create_file "app/frontend/controllers/index.ts", <<~TS
  import { Application } from "@hotwired/stimulus";

  const application = Application.start();
  application.debug = false;
  export { application };
TS

# Tailwind CSS v4 entry point — loaded separately via vite_stylesheet_tag.
# @source directives tell Tailwind where to scan for class names, since Rails
# ERB templates are not in Vite's module graph and won't be auto-detected.
create_file "app/frontend/entrypoints/application.css", <<~CSS
  @import "tailwindcss";
  @source "../../views/**/*.{erb,html}";
  @source "../../components/**/*.{erb,html,rb}";
  @source "../../helpers/**/*.rb";
CSS

# Install Tailwind CSS v4 with Vite plugin and Hotwire dependencies
run "yarn add -D @tailwindcss/vite tailwindcss"
run "yarn add @hotwired/turbo-rails @hotwired/stimulus"

# vite install injects its own tags into application.html.erb; restore Kickstart layouts
%w[application landing plain component_preview].each do |layout|
  copy_file "app/views/layouts/#{layout}.html.erb", force: true
end
