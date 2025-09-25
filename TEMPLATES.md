# Template Management System

This document describes the template management system for Kickstart Rails Templates.

## Overview

The Kickstart project uses a sophisticated template management system that provides:

- **Embedded shared code**: All templates are self-contained with embedded shared functions
- **Template validation**: Automated consistency checking across all templates
- **Template synchronization**: Tools to keep shared code in sync across templates
- **Metadata system**: Rich metadata for each template including features and descriptions

## Template Structure

Each template follows a consistent structure:

```ruby
# frozen_string_literal: true

#==============================================================================
# CONSTANTS - Template configuration and shared values
#==============================================================================

REPO_LINK = "https://github.com/alec-c4/kickstart.git"
AVAILABLE_TEMPLATE_NAMES = %w[api importmap_tailwind esbuild_tailwind].freeze
TEMPLATE_NAME = "template_name".freeze
RAILS_REQUIREMENT = ">= 8.1.0.beta.1"

TEMPLATE_METADATA = {
  name: "template_name",
  description: "Template description",
  features: %w[list of features],
  rails_version: RAILS_REQUIREMENT
}.freeze

#==============================================================================
# SHARED CODE - Embedded functions (auto-generated, do not edit manually)
#==============================================================================

# All shared functions are embedded here...

#==============================================================================
# TEMPLATE LOGIC - Template-specific configuration and workflow
#==============================================================================

# Template-specific logic here...
```

## Available Templates

### API Template (`api.rb`)

- **Description**: Rails API-only application with essential setup
- **Features**: postgresql, devcontainer, rspec, rubocop, uuid, i18n, kamal, solid_queue, solid_cache, solid_cable
- **Use case**: Backend APIs and microservices

### Importmap + Tailwind Template (`importmap_tailwind.rb`)

- **Description**: Rails app with Importmap and Tailwind CSS for modern frontend development
- **Features**: postgresql, devcontainer, rspec, rubocop, uuid, i18n, tailwind, importmap, turbo, stimulus, kamal, solid_queue, solid_cache, solid_cable
- **Use case**: Simple web applications with modern CSS framework

### ESBuild + Tailwind Template (`esbuild_tailwind.rb`)

- **Description**: Rails app with ESBuild and Tailwind CSS for modern frontend development
- **Features**: postgresql, devcontainer, rspec, rubocop, uuid, i18n, tailwind, esbuild, turbo, stimulus, kamal, solid_queue, solid_cache, solid_cable
- **Use case**: Modern web applications with advanced JavaScript bundling

## Rake Tasks

### `rake templates:validate`

Validates that all templates are consistent and properly formatted.

```bash
$ rake templates:validate
🔍 Validating template consistency...
✅ All templates are valid and consistent!
```

**Checks performed:**

- All required constants are present
- All required functions are defined
- Shared code sections are identical across templates
- Template files exist and are readable

### `rake templates:info`

Displays detailed information about all templates.

```bash
$ rake templates:info
📊 Kickstart Rails Templates Information
==================================================

🚀 Template: IMPORTMAP_TAILWIND
   File: importmap_tailwind.rb
   Lines: 118
   Description: Rails app with Importmap, Tailwind CSS and basic configuration
   Features: postgresql, devcontainer, rspec, rubocop, uuid, i18n, tailwind, importmap, turbo, stimulus, kamal, solid_queue, solid_cache, solid_cable
   Apply statements: 11
```

### `rake templates:sync`

Synchronizes shared code across all templates to ensure consistency.

```bash
$ rake templates:sync
🔄 Syncing shared code across all templates...
   ✅ Updated api.rb
   ✅ Updated importmap_tailwind.rb
   ✅ Updated esbuild_tailwind.rb
🎉 Shared code synchronization complete!
```

**⚠️ Important**: This task auto-generates the shared code section. Do not edit the shared code manually.

### `rake templates:create[name,source]`

Creates a new template based on an existing one.

```bash
$ rake templates:create[mobile,importmap_tailwind]
✅ Created new template: mobile.rb
✅ Created directories: src/mobile/, variants/mobile/
💡 Don't forget to update AVAILABLE_TEMPLATES constant!
```

## Usage Examples

### Local Development

```bash
# Use a template locally
rails new myapp -m /path/to/kickstart/importmap_tailwind.rb --database=postgresql --devcontainer --css=tailwind

# Validate templates before committing
rake templates:validate

# Get template information
rake templates:info
```

### Remote Installation

```bash
# Install via curl (most common usage)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)" -- myapp importmap_tailwind
```

## Maintenance Workflow

### Adding New Shared Functions

1. **Add the function to one template** (preferably `importmap_tailwind.rb`)
2. **Run sync task** to propagate to all templates:
   ```bash
   rake templates:sync
   ```
3. **Validate consistency**:
   ```bash
   rake templates:validate
   ```

### Creating New Templates

1. **Create from existing template**:
   ```bash
   rake templates:create[new_template,importmap_tailwind]
   ```
2. **Update constants** in `Rakefile` and new template
3. **Customize template-specific logic**
4. **Validate the new template**:
   ```bash
   rake templates:validate
   ```

### Modifying Existing Templates

1. **Edit template-specific sections only** (below `# TEMPLATE LOGIC`)
2. **Never edit the shared code section directly** (it's auto-generated)
3. **Always validate after changes**:
   ```bash
   rake templates:validate
   ```

## Architecture Benefits

### Self-Contained Templates

- ✅ Work with remote URLs (curl installation)
- ✅ No external dependencies
- ✅ Easy to debug - everything in one file
- ✅ Fast loading

### Automated Management

- ✅ Consistent shared code across templates
- ✅ Validation prevents configuration drift
- ✅ Easy to add new templates
- ✅ Clear separation of concerns

### Rich Metadata

- ✅ Self-documenting templates
- ✅ Feature tracking
- ✅ Version compatibility information
- ✅ Usage statistics

## Contributing

When contributing to templates:

1. **Always run validation** before submitting PRs
2. **Use the sync task** if you modify shared functions
3. **Update metadata** when adding/removing features
4. **Test both local and remote usage**
5. **Document any new conventions**

## Troubleshooting

### Template Validation Fails

```bash
❌ Shared code sections are not identical across templates
```

**Solution**: Run `rake templates:sync` to synchronize shared code.

### Missing Constants/Functions

```bash
❌ Missing constant TEMPLATE_METADATA in api.rb
```

**Solution**: Add the missing constant following the standard structure.

### Template Creation Issues

```bash
❌ Template 'mobile' already exists!
```

**Solution**: Use a different name or remove the existing template first.

---

For more information, see the [main README](README.md) or check the [Rakefile](Rakefile) for implementation details.
