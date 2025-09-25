# frozen_string_literal: true

require 'rake'
require 'fileutils'
require 'digest'

# Template management tasks for Kickstart Rails Templates
AVAILABLE_TEMPLATES = %w[api importmap_tailwind esbuild_tailwind].freeze
REPO_LINK = "https://github.com/alec-c4/kickstart.git"
RAILS_REQUIREMENT = ">= 8.1.0.beta.1"

namespace :templates do
  desc "Validate template consistency and shared code synchronization"
  task :validate do
    puts "🔍 Validating template consistency..."

    errors = []
    shared_code_hashes = {}

    AVAILABLE_TEMPLATES.each do |template_name|
      template_file = "#{template_name}.rb"

      unless File.exist?(template_file)
        errors << "❌ Template file missing: #{template_file}"
        next
      end

      content = File.read(template_file)

      # Extract shared code section
      shared_section = extract_shared_code_section(content)
      if shared_section
        hash = Digest::SHA256.hexdigest(shared_section)
        shared_code_hashes[template_name] = hash
      else
        errors << "❌ No shared code section found in #{template_file}"
      end

      # Check required constants
      required_constants = %w[REPO_LINK AVAILABLE_TEMPLATE_NAMES TEMPLATE_NAME RAILS_REQUIREMENT]
      required_constants.each do |constant|
        unless content.include?(constant)
          errors << "❌ Missing constant #{constant} in #{template_file}"
        end
      end

      # Check required functions
      required_functions = %w[assert_minimum_rails_version gemfile_requirement add_template_repository_to_source_path set_variant_source_path show_post_install_message]
      required_functions.each do |function|
        unless content.include?("def #{function}")
          errors << "❌ Missing function #{function} in #{template_file}"
        end
      end
    end

    # Check if all shared code sections are identical
    if shared_code_hashes.values.uniq.size > 1
      errors << "❌ Shared code sections are not identical across templates"
      puts "   Template hashes:"
      shared_code_hashes.each do |template, hash|
        puts "     #{template}: #{hash[0..12]}..."
      end
    end

    if errors.empty?
      puts "✅ All templates are valid and consistent!"
    else
      puts "\n❌ Validation errors found:"
      errors.each { |error| puts "   #{error}" }
      exit 1
    end
  end

  desc "Show template information and statistics"
  task :info do
    puts "📊 Kickstart Rails Templates Information"
    puts "=" * 50

    AVAILABLE_TEMPLATES.each do |template_name|
      template_file = "#{template_name}.rb"

      if File.exist?(template_file)
        content = File.read(template_file)
        lines = content.lines.size

        # Extract metadata if present
        metadata = extract_template_metadata(content)

        puts "\n🚀 Template: #{template_name.upcase}"
        puts "   File: #{template_file}"
        puts "   Lines: #{lines}"

        if metadata
          puts "   Description: #{metadata[:description]}" if metadata[:description]
          puts "   Features: #{metadata[:features].join(', ')}" if metadata[:features]
        end

        # Count apply statements
        apply_count = content.scan(/apply\s+"/).size
        puts "   Apply statements: #{apply_count}"

      else
        puts "\n❌ Template: #{template_name.upcase} (FILE MISSING)"
      end
    end

    puts "\n📋 Global Configuration:"
    puts "   Repository: #{REPO_LINK}"
    puts "   Rails requirement: #{RAILS_REQUIREMENT}"
    puts "   Available templates: #{AVAILABLE_TEMPLATES.join(', ')}"
  end

  desc "Generate shared code from source and sync to all templates"
  task :sync do
    puts "🔄 Syncing shared code across all templates..."

    shared_code = generate_shared_code_section

    AVAILABLE_TEMPLATES.each do |template_name|
      template_file = "#{template_name}.rb"

      unless File.exist?(template_file)
        puts "   ❌ Skipping missing template: #{template_file}"
        next
      end

      content = File.read(template_file)
      updated_content = update_shared_code_section(content, shared_code, template_name)

      if content != updated_content
        File.write(template_file, updated_content)
        puts "   ✅ Updated #{template_file}"
      else
        puts "   ✨ #{template_file} already up to date"
      end
    end

    puts "🎉 Shared code synchronization complete!"
  end

  desc "Create a new template from existing one"
  task :create, [:name, :source] do |t, args|
    template_name = args[:name]
    source_template = args[:source] || 'importmap_tailwind'

    if template_name.nil?
      puts "❌ Usage: rake templates:create[template_name,source_template]"
      exit 1
    end

    if AVAILABLE_TEMPLATES.include?(template_name)
      puts "❌ Template '#{template_name}' already exists!"
      exit 1
    end

    source_file = "#{source_template}.rb"
    unless File.exist?(source_file)
      puts "❌ Source template '#{source_template}' not found!"
      exit 1
    end

    # Create new template file
    content = File.read(source_file)
    new_content = content.gsub(/TEMPLATE_NAME = "#{source_template}"/, "TEMPLATE_NAME = \"#{template_name}\"")

    new_file = "#{template_name}.rb"
    File.write(new_file, new_content)

    # Create variant directories
    %W[src/#{template_name} variants/#{template_name}].each do |dir|
      FileUtils.mkdir_p(dir)
      File.write(File.join(dir, '.keep'), '')
    end

    puts "✅ Created new template: #{new_file}"
    puts "✅ Created directories: src/#{template_name}/, variants/#{template_name}/"
    puts "💡 Don't forget to update AVAILABLE_TEMPLATES constant!"
  end

  private

  def extract_shared_code_section(content)
    start_marker = '#' + '=' * 78 + "\n# SHARED CODE"
    end_marker = '#' + '=' * 78 + "\n# TEMPLATE LOGIC"

    start_idx = content.index(start_marker)
    end_idx = content.index(end_marker)

    return nil unless start_idx && end_idx

    content[start_idx...end_idx].strip
  end

  def extract_template_metadata(content)
    metadata_match = content.match(/TEMPLATE_METADATA\s*=\s*\{([^}]+)\}/m)
    return nil unless metadata_match

    # Simple parsing - would need more sophisticated parsing for complex cases
    metadata_str = metadata_match[1]

    metadata = {}
    metadata[:description] = metadata_str[/description:\s*['"](.*?)['"]/, 1]
    features_match = metadata_str.match(/features:\s*%w\[(.*?)\]/)
    metadata[:features] = features_match ? features_match[1].split : []

    metadata
  end

  def generate_shared_code_section
    <<~RUBY
      #==============================================================================
      # SHARED CODE - Embedded functions (auto-generated, do not edit manually)
      #==============================================================================

      require "rails/all"


      def assert_minimum_rails_version
        requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
        rails_version = Gem::Version.new(Rails::VERSION::STRING)
        return if requirement.satisfied_by?(rails_version)

        prompt = "This template requires Rails \#{RAILS_REQUIREMENT}. "\
                 "You are using \#{rails_version}. Continue anyway?"
        exit 1 if no?(prompt)
      end

      def gemfile_requirement(name)
        @original_gemfile ||= IO.read("Gemfile")
        req = @original_gemfile[/gem\\s+['\"]#\{name\}['\"]\\s*(,[><~= \\t\\d.\\w'\"]*)?.*$/, 1]
        req && req.tr("'", %(\")).strip.sub(/^,\\s*\"/, ', \"')
      end

      def add_template_repository_to_source_path
        if __FILE__.match?(%r{\\Ahttps?://})
          require "tmpdir"
          source_paths.unshift(tempdir = Dir.mktmpdir("kickstart-tmp"))
          at_exit { FileUtils.remove_entry(tempdir) }
          git clone: [
            "--quiet",
            REPO_LINK,
            tempdir
          ].map(&:shellescape).join(" ")

          # Check for specific branch in URL path (e.g., /kickstart/branch_name/template.rb)
          template_pattern = "(?:#\{AVAILABLE_TEMPLATE_NAMES.join('|')})"
          if (branch = __FILE__[%r{kickstart/(.+)/#\{template_pattern\}\\.rb}, 1])
            Dir.chdir(tempdir) { git checkout: branch }
          end
        else
          # For local files, add the template root directory
          template_root = File.dirname(__FILE__)
          source_paths.unshift(template_root)
        end
      end

      def set_variant_source_path(variant_name = nil)
        template_root = __FILE__.match?(%r{\\Ahttps?://}) ?
          source_paths.first : File.dirname(__FILE__)

        if variant_name
          variant_path = File.join(template_root, "variants", variant_name)
          source_paths.unshift(variant_path) if File.directory?(variant_path)
        end

        shared_path = File.join(template_root, "variants", "shared")
        source_paths.unshift(shared_path) if File.directory?(shared_path)
      end

      def show_post_install_message
        say "\\n
        #########################################################################################

        Rails application '\#{app_name}' created successfully!

        Next steps:
        $ cd \#{app_name}
        $ bundle install
        $ rails db:create db:migrate
        $ bin/dev

        #########################################################################################\\n", :green
      end
    RUBY
  end

  def update_shared_code_section(content, new_shared_code, template_name)
    start_marker = /#={'=' * 78}\n# SHARED CODE/
    end_marker = /#={'=' * 78}\n# TEMPLATE LOGIC/

    # Find the shared code section
    if content.match(start_marker) && content.match(end_marker)
      # Replace existing shared code section
      content.gsub(/#{start_marker}.*?(?=#{end_marker})/m, new_shared_code + "\n\n")
    else
      # Add shared code section if not found
      constants_end = content.index("\n\n") || 0
      constants_part = content[0..constants_end]
      rest_part = content[constants_end + 1..-1]

      constants_part + "\n" + new_shared_code + "\n\n" +
        "#" + "=" * 78 + "\n" +
        "# TEMPLATE LOGIC - Template-specific configuration and workflow\n" +
        "#" + "=" * 78 + "\n\n" +
        rest_part
    end
  end
end

# Default task
task default: %w[templates:validate]