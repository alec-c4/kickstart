# Update application.css to support dark mode in Tailwind v4
application_css_path = "app/frontend/entrypoints/application.css"

if File.exist?(application_css_path)
  content = File.read(application_css_path)
  
  # Add dark mode variant if not already present
  unless content.include?("@variant dark")
    content += "\n@variant dark (&:where(.dark, .dark *));\n"
    File.write(application_css_path, content)
    say "✓ Added dark mode support to application.css", :green
  end
end
