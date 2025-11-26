# Kickstart

There are a collection of application templates, scripts, and automatizations I use for everyday work. All included code is written with the following principles:

- Code is testable
- Code is written to be supported without a hassle
- Code is written, following best practices from developers and product communities

Feel free to submit any feature or pull request if you think that it may be useful for the community.

## Quick Reference - Create New App

### Easiest Way (Recommended)

Use the interactive installer script:

```bash
# Interactive mode - select template from menu
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)" -- myapp

# Or specify template directly
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)" -- myapp esbuild_tailwind
```

Available templates: `esbuild_tailwind`, `importmap_tailwind`, `inertia_react`, `inertia_vue`, `inertia_svelte`, `api`

### Direct Rails Command

If you prefer to use `rails new` directly:

```bash
# ESBuild + Tailwind (Classic Rails with Turbo/Stimulus)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/esbuild_tailwind.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --css=tailwind --javascript=esbuild

# Importmap + Tailwind (Classic Rails with Turbo/Stimulus)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/importmap_tailwind.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --css=tailwind

# Inertia + React (Modern SPA)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/inertia_react.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# Inertia + Vue (Modern SPA)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/inertia_vue.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# Inertia + Svelte (Modern SPA)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/inertia_svelte.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# API Only (REST API)
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/api.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --api
```

**After app creation:**

```bash
cd myapp
bundle install
yarn install  # Only for esbuild_tailwind and Inertia templates
rails db:create db:migrate
rails parallel:create  # Creates parallel test databases
bin/dev
```

## Usage

See [Quick Reference](#quick-reference---create-new-app) above for creating new applications.

The interactive installer (`install.sh`) will:

- Prompt you to select a template (if not specified)
- Check for required dependencies (Ruby, Rails, PostgreSQL)
- Create the Rails application with the chosen template
- Set up the development environment

## Templates

### esbuild_tailwind

Modern Rails application with ESBuild bundling and Tailwind CSS.

**Frontend:**

- ESBuild + Tailwind CSS
- Turbo & Stimulus
- ViewComponent with Lookbook
- Better HTML & ERB Lint

**Backend:**

- PostgreSQL with UUID support
- Anyway Config for settings
- Active Interaction for service objects
- Active Decorator for presenters
- Pagy for pagination
- Shrine for file uploads
- Lockbox & Blind Index for encryption

**Development:**

- RSpec with parallel_tests support
- Rubocop, Brakeman
- Devcontainer ready
- I18n with i18n-tasks
- Custom error pages (404, 422, 406, 500)

**Deployment:**

- Kamal deployment ready
- Solid Queue, Cache, Cable

### importmap_tailwind

Rails application with Import Maps and Tailwind CSS.

**Frontend:**

- Import Maps + Tailwind CSS
- Turbo & Stimulus
- ViewComponent with Lookbook
- Better HTML & ERB Lint

**Backend & Deployment:**

- Same as esbuild_tailwind (see above)

### inertia_svelte

Modern SPA with Inertia.js and Svelte 5 for reactive interfaces.

**Frontend:**

- Vite + Tailwind CSS
- Inertia.js for SPA architecture
- Svelte 5 with runes and reactivity
- No Turbo/Stimulus (full SPA approach)

**Backend:**

- PostgreSQL with UUID support
- Anyway Config for settings
- Active Interaction for service objects
- Active Decorator for presenters
- Pagy for pagination
- Shrine for file uploads
- Lockbox & Blind Index for encryption

**Development:**

- RSpec with parallel_tests support
- Rubocop, Brakeman
- Devcontainer ready
- I18n with i18n-tasks
- Generators configured for Inertia (no JS/asset generation)

**Deployment:**

- Kamal deployment ready
- Solid Queue, Cache, Cable

### inertia_react

Modern SPA with Inertia.js and React for component-based UIs.

**Frontend:**

- Vite + Tailwind CSS
- Inertia.js for SPA architecture
- React with hooks and TypeScript
- No Turbo/Stimulus (full SPA approach)

**Backend & Development:**

- Same as inertia_svelte (see above)

### inertia_vue

Modern SPA with Inertia.js and Vue 3 for progressive interfaces.

**Frontend:**

- Vite + Tailwind CSS
- Inertia.js for SPA architecture
- Vue 3 Composition API with TypeScript
- No Turbo/Stimulus (full SPA approach)

**Backend & Development:**

- Same as inertia_svelte (see above)

### api

Rails API-only application for backend services.

**Backend:**

- PostgreSQL with UUID support
- Anyway Config for settings
- Active Interaction for service objects
- Pagy for pagination
- Shrine for file uploads
- Lockbox & Blind Index for encryption

**Development:**

- RSpec with parallel_tests support
- Rubocop, Brakeman
- I18n with i18n-tasks

**Deployment:**

- Kamal deployment ready
- Solid Queue, Cache, Cable

## Local Development Usage

If you have cloned this repository locally, you can use the templates with local file paths:

```bash
# ESBuild + Tailwind
rails new myapp -m ~/path/to/kickstart/esbuild_tailwind.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --css=tailwind --javascript=esbuild

# Importmap + Tailwind
rails new myapp -m ~/path/to/kickstart/importmap_tailwind.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --css=tailwind

# Inertia + React
rails new myapp -m ~/path/to/kickstart/inertia_react.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# Inertia + Vue
rails new myapp -m ~/path/to/kickstart/inertia_vue.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# Inertia + Svelte
rails new myapp -m ~/path/to/kickstart/inertia_svelte.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --skip-javascript

# API Only
rails new myapp -m ~/path/to/kickstart/api.rb \
  --no-rc --skip-test --skip-system-test --database=postgresql \
  --devcontainer --api
```

## Post-Creation Setup

After creating your app with one of the templates above:

```bash
cd myapp

# Install dependencies
bundle install
yarn install  # Only needed for: esbuild_tailwind, inertia_react, inertia_vue, inertia_svelte

# Setup database
rails db:create db:migrate
rails parallel:create  # Creates parallel test databases (ignore 'already exists' message)

# Run tests to verify everything works
bundle exec rspec

# Start development server
bin/dev  # Runs Rails + Vite (for Inertia) or Rails + Asset pipeline (for classic templates)
```

**Note for Inertia templates:** The Inertia generator automatically:

- Installs and configures Vite Rails for frontend bundling
- Sets up Inertia.js with your chosen framework (React/Vue/Svelte)
- Configures Tailwind CSS
- Creates base layouts and components
- Configures TypeScript support

## Features

### Custom Error Pages

All templates (classic and Inertia) include custom error pages for:

- 404 - Page not found
- 422 - Unprocessable entity
- 406 - Not acceptable
- 500 - Internal server error

**Testing in Development:**

By default, Rails shows detailed error pages in development. To test custom error pages locally:

```bash
# Enable custom error pages
rails dev:errors

# Restart your server
bin/dev

# Disable custom error pages (back to default)
rails dev:errors
```

## TODO

Add new templates

- GraphQL API

## Known issues

Not found

## Note

Previous versions of kickstart templates can be found here due to complete project rewrite with master repo reboot.

- [Monolith ruby on rails application with tailwindcss frontend](https://github.com/alec-c4/ks-rails-tailwind)
- [Monolith ruby on rails application with bootstrap frontend](https://github.com/alec-c4/ks-rails-bootstrap)
- [Rails API application](https://github.com/alec-c4/ks-rails-api)
- [Rails basic/plain application](https://github.com/alec-c4/ks-rails-basic)

## Contributing [![PRs welcome](https://img.shields.io/badge/PRs-welcome-orange.svg?style=flat-square)](https://github.com/alec-c4/kickstart/issues)

For bug fixes, documentation changes, and features:

1. [Fork it](./fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

For larger new features: Do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction.
