# Kickstart application

## Usage instructions


1. Fill credentials file with

``` yml
app:
  secret_key: ''
google:
  client_id: ''
  client_secret: ''
mailgun:
  api_key: ''
  domain: ''
lockbox:
  master_key: ''
```

using 

``` bash
$ rails credentials:edit --environment development
```

Key for LockBox you can create in rails console with

``` ruby
Lockbox.generate_key
```

2. Uncomment following line in `config/initializers/devise.rb` file

``` ruby
config.omniauth :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], name: "google"
```

3. Configure mail sender in `config\setting.yml` file

4. Configure rack-attack using following [guide](https://expeditedsecurity.com/blog/ultimate-guide-to-rack-attack/)

5. Add [legal documents](https://github.com/ankane/awesome-legal).

## What's inside

- ruby on rails application template 
- .gitignore file
- [VSCode](https://code.visualstudio.com/) configuration files
- postgresql database connector
- bootstrap frontend frameworks with scaffold templates 
- [purge.css](https://purgecss.com/) to cleanup stylesheets
- timezone detection with [jstz](https://github.com/iansinnott/jstz)
- typescript for frontend
- Procfile to run app, webpacker and sidekiq
- [Sidekiq](https://github.com/mperham/sidekiq) for background jobs
- [strong_migrations](https://github.com/ankane/strong_migrations)
- authentication with [devise](https://github.com/heartcombo/devise) and [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password) + google auth
- [devise_masquerade](https://github.com/oivoodoo/devise_masquerade)
- authorization with [pundit](https://github.com/varvet/pundit)
- role management with [rolify](https://github.com/RolifyCommunity/rolify)
- ability to ban user account
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
- [ahoy](https://github.com/ankane/ahoy), [ahoy_email](https://github.com/ankane/ahoy_email) and [blazer](https://github.com/ankane/blazer) for business intelligence
- [noticed](https://github.com/excid3/noticed) for notifications
- [annotate](https://github.com/ctran/annotate_models) for annotations
- [lol_dba](https://github.com/plentz/lol_dba) for indexing
- [lockbox](https://github.com/ankane/lockbox) and [blind_index](https://github.com/ankane/blind_index) for email fields encryption
- [rack-attack](https://github.com/rack/rack-attack) to prevent bruteforce and DDoS attacks 
- [capistrano](http://www.capistranorb.com) with plugins for deployment
- announcements (new/fix/update) for all users
- flash helper
- referral system
- landing page
- profiles controller
- admin and customer dashboards
- users administration with search
