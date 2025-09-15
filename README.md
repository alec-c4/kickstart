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

### Manual Usage

If you prefer to use Rails templates directly:

```bash
# Using the ESBuild + Tailwind template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/esbuild_tailwind.rb --no-rc

# Using the API template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/api.rb --no-rc

# Using the minimal template
rails new myapp -m https://raw.githubusercontent.com/alec-c4/kickstart/master/minimal.rb --no-rc

# For local development/testing
rails new myapp -m /path/to/kickstart/esbuild_tailwind.rb --no-rc
```

### Available Templates

#### esbuild_tailwind

Modern Rails application with ESBuild and Tailwind CSS setup.

**Features:**

- **Frontend:** ESBuild (jsbundling-rails) + Tailwind CSS (cssbundling-rails)
- **Asset Pipeline:** Propshaft
- **JavaScript Framework:** Turbo + Stimulus
- **Database:** PostgreSQL
- **Solid Stack:** Solid Cache, Solid Queue, Solid Cable
- **Deployment:** Kamal + Thruster ready
- **Testing:** RSpec with Faker and Database Cleaner
- **Code Quality:** Standard (Ruby), Rubocop, Brakeman security scanner
- **Development Tools:** Web Console, Letter Opener Web, Amazing Print
- **I18n:** Rails I18n with i18n-tasks
- **Devcontainer:** Pre-configured development environment

**Generated with:**

```bash
rails new myapp --skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind --javascript=esbuild
```

#### minimal

Streamlined Rails application with essential configuration and modern defaults.

**Features:**

- **Frontend:** Importmap + Tailwind CSS (tailwindcss-rails)
- **JavaScript Framework:** Turbo + Stimulus
- **Database:** PostgreSQL
- **Solid Stack:** Solid Cache, Solid Queue, Solid Cable
- **Deployment:** Kamal + Thruster ready
- **Testing:** RSpec with Faker and Database Cleaner
- **Code Quality:** Standard (Ruby), Rubocop, Brakeman security scanner
- **Development Tools:** Web Console, Letter Opener Web, Amazing Print
- **I18n:** Rails I18n with i18n-tasks
- **Devcontainer:** Pre-configured development environment

**Generated with:**

```bash
rails new myapp --skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind
```

#### api

Rails API-only application optimized for backend services and microservices.

**Features:**

- **API Mode:** Rails API-only configuration
- **Database:** PostgreSQL
- **CORS:** Rack-CORS for cross-origin requests
- **Solid Stack:** Solid Cache, Solid Queue, Solid Cable
- **Deployment:** Kamal + Thruster ready
- **Testing:** RSpec with Faker and Database Cleaner
- **Code Quality:** Standard (Ruby), Rubocop, Brakeman security scanner
- **Development Tools:** Amazing Print for debugging
- **I18n:** Rails I18n with i18n-tasks
- **JSON Builder:** JBuilder for API responses

**Generated with:**

```bash
rails new myapp --skip-test --skip-system-test --database=postgresql --devcontainer --api
```

### Prerequisites

Before using any template, ensure you have:

- **Ruby** (version 3.1.0 or higher recommended)
- **Rails** (version 8.1 or higher)
- **PostgreSQL** (for database)
- **Node.js** and **npm** (for JavaScript dependencies)
- **Git** (for version control)

Check your environment:

```bash
ruby --version
rails --version
psql --version
node --version
npm --version
```

### Post-Installation Steps

After creating your application:

1. **Navigate to your app directory:**

   ```bash
   cd myapp
   ```

2. **Install dependencies:**

   ```bash
   bundle install
   npm install  # (for esbuild_tailwind template)
   ```

3. **Set up the database:**

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the development server:**
   ```bash
   rails server
   # or for esbuild_tailwind:
   bin/dev  # starts both Rails and asset compilation
   ```

### Customization

Each template includes sensible defaults but can be customized:

- Modify `config/application.rb` for application-wide settings
- Update `Gemfile` to add/remove gems
- Customize Tailwind configuration in `tailwind.config.js` (esbuild_tailwind)
- Adjust ESBuild settings in `esbuild.config.js` (esbuild_tailwind)

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
