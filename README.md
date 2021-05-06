# Kickstart

## Usage instructions

1. Install rbenv, ruby (2.6+), node.js and yarn.
2. Install latest ruby on rails version.
3. Install PostgreSQL database and Redis key-value server.
4. Create [Mailgun](https://mailgun.com) account. We'll use it to send emails.
5. Install [hivemind](https://github.com/DarthSim/hivemind). We'll use it to start server.
6. Copy .railsrc file to your home directory
7. Clone repository localy
8. Run from console 

```
$ rails new app_name -m /path/to/template
$ rails credentials:edit --environment development
$ rails db:create
$ rails db:migrate
```

9. Uncomment following line in **config/initializers/devise.rb** file

``` ruby
config.omniauth :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], name: "google"
```

10. (IMPORTANT!!!) Replace method is_admin in app/models/user.rb with your code.
11. Replace following line in app/mailers/application_mailer.rb with your code

```
default from: "from@example.com"
```

12. Replace following line in config/initializers/devise.rb with your code

```
config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
```

## What's inside

- ruby on rails application template 
- postgresql database connector
- [vite](https://vitejs.dev) as a frontend builder
- bootstrap or tailwind.css frontend frameworks with scaffold templates 
- [purge.css](https://purgecss.com/) to cleanup stylesheets
- timezone detection with [jstz](https://github.com/iansinnott/jstz)
- typescript for frontend
- Procfile to run app, vite and sidekiq
- [Sidekiq](https://github.com/mperham/sidekiq) for background jobs
- [VSCode](https://code.visualstudio.com/) configuration files
- .gitignore file
- [strong_migrations](https://github.com/ankane/strong_migrations)
- authentication with [devise](https://github.com/heartcombo/devise) and [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password) + google auth
- [name_of_person](https://github.com/basecamp/name_of_person) to display username in different formats
- authorization with [pundit](https://github.com/varvet/pundit)
- pre-configured generators
- SEO tools - [meta-tags](https://github.com/kpumuk/meta-tags), [sitemap_generator](http://github.com/kjvarga/sitemap_generator) and [friendly_id](https://github.com/norman/friendly_id)
- I18n tools - [rails-i18n](http://github.com/svenfuchs/rails-i18n) and [i18n-tasks](https://github.com/glebm/i18n-tasks)
- rspec and cucumber for testing
- [Mailgun](https://mailgun.com) integration for email notifications
- [rubocop](https://github.com/rubocop/rubocop/) for code style validations
- [bullet](https://github.com/flyerhzm/bullet) to prevent N+1 problems
- [brakeman](https://github.com/presidentbeef/brakeman) and [bundler-audit](https://github.com/postmodern/bundler-audit) as security scanners
- [fasterer](https://github.com/DamirSvrtan/fasterer) for performance optimization
- [pry-rails](https://github.com/rweng/pry-rails) and [amazing_print](https://github.com/amazing-print/amazing_print) for better rails console
- [active_interaction](https://github.com/AaronLasseigne/active_interaction) to make controllers thin
- [view_component](https://viewcomponent.org/) as a replacement for partials
- [flipper](https://github.com/jnunemaker/flipper) with Flipper UI to enable [flag management](https://boringrails.com/articles/feature-flags-simplest-thing-that-could-work/)
- [ahoy](https://github.com/ankane/ahoy) and [blazer](https://github.com/ankane/blazer) for business intelligence
- flash helper
- referral system
- landing page
- profiles controller
- admin and customer dashboards

## Todo

- add [erb linter](https://github.com/Shopify/erb-lint)
- add documentation (howto's, best practices, curated list of libraries)
- add deployments tools
- add [devise_masquerade](https://github.com/oivoodoo/devise_masquerade)
- add [hotwire](https://hotwire.dev/)
- add [notices](https://github.com/excid3/noticed)
- add [ahoy_email](https://github.com/ankane/ahoy_email) and [mailkick](https://github.com/ankane/mailkick)
- add monitoring and analytics tools
- add A11y
- configure Tailwind.css JIT