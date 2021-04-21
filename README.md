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
```

## What's inside

- ruby on rails application template 
- postgresql database connector
- vite as a frontend builder
- bootstrap or tailwind.css frontend frameworks with scaffold templates 
- [purge.css](https://purgecss.com/) to cleanup stylesheets
- timezone detection with [jstz](https://github.com/iansinnott/jstz)
- typescript for frontend
- Procfile to run app, vite and sidekiq
- [Sidekiq](https://github.com/mperham/sidekiq) for background jobs
- [VSCode](https://code.visualstudio.com/) configuration files
- .gitignore file
- [strong_migrations](https://github.com/ankane/strong_migrations)
- authentication with [devise](https://github.com/heartcombo/devise) and [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password)
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
- flash helper
- landing page
- profiles controller
- admin and customer dashboards

