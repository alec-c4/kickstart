# Setup i18n for Inertia frontend based on framework
framework = case TEMPLATE_NAME
            when "inertia_react" then "react"
            when "inertia_vue" then "vue"
            when "inertia_svelte" then "svelte"
            else
              raise "Unknown Inertia template: #{TEMPLATE_NAME}"
            end

say "Setting up i18n and dark mode for #{framework}...", :blue

# Install base i18n dependencies based on framework
case framework
when "react"
  run "yarn add i18next react-i18next"
  run "yarn add -D i18next-parser"
when "vue"
  run "yarn add vue-i18n@9"
  run "yarn add -D i18next-parser"
when "svelte"
  run "yarn add i18next"
  run "yarn add -D i18next-parser"
end

# Copy locale files
copy_file "app/frontend/locales/en.json"
copy_file "app/frontend/locales/ru.json"
say "✓ Copied locale files (en.json, ru.json)", :green

# Create i18next-parser config
create_file "config/i18next-parser.config.js", <<~JS
  module.exports = {
    locales: ['en', 'ru'],
    output: 'app/frontend/locales/$LOCALE.json',
    input: [
      'app/frontend/pages/**/*.{#{framework == 'svelte' ? 'svelte' : framework == 'vue' ? 'vue' : 'tsx,ts,jsx,js'}}',
      'app/frontend/components/**/*.{#{framework == 'svelte' ? 'svelte' : framework == 'vue' ? 'vue' : 'tsx,ts,jsx,js'}}',
      'app/frontend/layouts/**/*.{#{framework == 'svelte' ? 'svelte' : framework == 'vue' ? 'vue' : 'tsx,ts,jsx,js'}}',
      'app/frontend/lib/**/*.{#{framework == 'svelte' ? 'svelte,ts' : framework == 'vue' ? 'vue,ts' : 'tsx,ts,jsx,js'}}'
    ],
    defaultNamespace: 'translation',
    keySeparator: '.',
    createOldCatalogs: false,
    keepRemoved: false,
    lexers: {
      #{framework == 'svelte' ? "svelte: ['JavascriptLexer']," : ''}
      #{framework == 'vue' ? "vue: ['JavascriptLexer']," : ''}
      #{framework == 'react' ? "tsx: ['JsxLexer']," : ''}
      ts: ['JavascriptLexer'],
      js: ['JavascriptLexer']
    }
  };
JS

# Add i18n scripts to package.json
package_json_path = "package.json"
if File.exist?(package_json_path)
  package_json = JSON.parse(File.read(package_json_path))
  package_json["scripts"] ||= {}
  package_json["scripts"]["i18n:extract"] = "i18next --config config/i18next-parser.config.js"
  File.write(package_json_path, JSON.pretty_generate(package_json))
  say "✓ Added i18n:extract script to package.json", :green
end

say "✓ i18n setup complete for #{framework}", :green
say "  Run 'yarn i18n:extract' to extract translation keys", :blue
