# Kickstart

There are a collection of application templates, scripts, and automatizations I use for everyday work. All included code is written with the following principles:

- Code is testable
- Code is written to be supported without a hassle
- Code is written, following best practices from developers and product communities

Feel free to submit any feature or pull request if you think that it may be useful for the community.

## Usage instructions

### Quick Start (Recommended)

Create a new Rails application using the interactive installer:

```bash
# Interactive mode - select template from menu
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)" -- myapp

# Specify template directly
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)" -- myapp esbuild_tailwind
```

The installer will:

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

## Manual Usage

```bash
# ESBuild + Tailwind template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/esbuild_tailwind.rb --no-rc --skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind --javascript=esbuild

# Importmap + Tailwind template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/importmap_tailwind.rb --no-rc --skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind

# API template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/api.rb --no-rc --skip-test --skip-system-test --database=postgresql --devcontainer --api
```

## Setup

```bash
cd myapp
bundle install
yarn install  # for esbuild_tailwind only
rails db:create db:migrate
rails parallel:create  # Creates parallel test databases (ignore 'already exists' message)
bin/dev      # or rails server
```

## Features

### Custom Error Pages

The esbuild_tailwind and importmap_tailwind templates include custom error pages styled with Tailwind CSS for:
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
- Inertia.js + Svelte
- Inertia.js + React

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
