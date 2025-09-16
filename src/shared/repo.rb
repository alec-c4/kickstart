# frozen_string_literal: true

REPO_LINK = "https://github.com/alec-c4/kickstart.git"
AVAILABLE_TEMPLATE_NAMES = %w[api minimal esbuild_tailwind].freeze

def add_template_repository_to_source_path
  if __FILE__.match?(%r{\Ahttps?://})
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("kickstart-tmp"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      REPO_LINK,
      tempdir
    ].map(&:shellescape).join(" ")

    # Check for specific branch in URL path (e.g., /kickstart/branch_name/template.rb)
    template_pattern = "(?:#{AVAILABLE_TEMPLATE_NAMES.join('|')})"
    if (branch = __FILE__[%r{kickstart/(.+)/#{template_pattern}\.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    # For local files, add the template root directory (go up from src/shared)
    template_root = File.expand_path("../..", File.dirname(__FILE__))
    source_paths.unshift(template_root)
  end
end

def set_variant_source_path(variant_name = nil)
  # Find template root - go up from src/shared to the main directory
  template_root = File.expand_path("../..", File.dirname(__FILE__))

  if variant_name
    variant_path = File.join(template_root, "variants", variant_name)
    source_paths.unshift(variant_path) if File.directory?(variant_path)
  end

  # Always add shared variant path
  shared_path = File.join(template_root, "variants", "shared")
  source_paths.unshift(shared_path) if File.directory?(shared_path)
end
