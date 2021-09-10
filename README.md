# Kickstart

## Usage instructions

1. Install rbenv, ruby (2.6+), node.js and yarn.
2. Install latest ruby on rails version.
3. Install PostgreSQL database  
4. Install Redis key-value server
5. Install memcached
6. Create [Mailgun](https://mailgun.com) account. We'll use it to send emails.
7. Install [hivemind](https://github.com/DarthSim/hivemind). We'll use it to start server.
8. Copy .railsrc file to your home directory
9. Clone repository localy
10. Run from console 

``` bash
$ rails new app_name -m /path/to/template
$ rails credentials:edit --environment development
$ rails db:create
$ rails db:migrate
```

Fill credentials file with keys, following example in `credentials.example` file. Key for LockBox you can create in rails console with

``` ruby
Lockbox.generate_key
```

11. Uncomment following line in `config/initializers/devise.rb` file

``` ruby
config.omniauth :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], name: "google"
```

12. Configure mail sender in `config/setting.yml` file

13. Configure rack-attack using following [guide](https://expeditedsecurity.com/blog/ultimate-guide-to-rack-attack/)

14. Add [legal documents](https://github.com/ankane/awesome-legal).

15. Update error pages in `app/views/errors/*` with your content 

16. Install [lefthook](https://github.com/evilmartians/lefthook/) and hooks

```bash
$ gem install lefthook
$ lefthook install
$ lefthook run pre-commit
```

17. Create secret token using 

```
$ openssl rand -base64 32
```

and add it to GitHub repo settings (settings/secrets) with name DANGER_GITHUB_API_TOKEN


## Setup for production

0. Install PostgreSQL, Redis, memcached, nginx, rbenv and ruby to your server.
1. Create [Mailgun](https://mailgun.com) account if you haven't done it before
2. Create [Appsignal](https://appsignal.com/r/53a0242a45) account, install it to your app
3. Register keys for Google authentication in [Google API console](https://console.cloud.google.com/apis/)
4. Fill credentials with `rails credentials:edit` 

## What's inside

- ruby on rails application template 
- .gitignore file
- [VSCode](https://code.visualstudio.com/) configuration files
- [Danger](https://danger.systems/ruby/) configuration with auto assign github actions
- postgresql database connector
- [purge.css](https://purgecss.com/) to cleanup stylesheets
- timezone detection with [jstz](https://github.com/iansinnott/jstz)
- typescript for frontend
- Procfile to run app, webpacker and sidekiq
- [Sidekiq](https://github.com/mperham/sidekiq) for background jobs
- [strong_migrations](https://github.com/ankane/strong_migrations)
- authentication with [devise](https://github.com/heartcombo/devise) and [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password) + google auth
- [pretender](https://github.com/ankane/pretender)
- authorization with [pundit](https://github.com/varvet/pundit)
- role management with [rolify](https://github.com/RolifyCommunity/rolify)
- ability to ban user account
- pre-configured generators
- SEO tools - [meta-tags](https://github.com/kpumuk/meta-tags), [sitemap_generator](http://github.com/kjvarga/sitemap_generator) and [friendly_id](https://github.com/norman/friendly_id)
- I18n tools - [rails-i18n](http://github.com/svenfuchs/rails-i18n) and [i18n-tasks](https://github.com/glebm/i18n-tasks)
- rspec and cucumber for testing
- [rspec-sidekiq](https://github.com/philostler/rspec-sidekiq) plugin
- [rails_best_practices](https://github.com/flyerhzm/rails_best_practices)
- [Mailgun](https://mailgun.com) integration for email notifications
- [rubocop](https://github.com/rubocop/rubocop/) for code style validations
- [better_html](https://github.com/Shopify/better-html) and [erb-lint](https://github.com/Shopify/erb-lint) for erb linting
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
- [authrail](https://github.com/ankane/authtrail) to track login attempts
- [lefthook](https://github.com/evilmartians/lefthook) with pre-commit run of rspec, brakeman, rubocop, erblint, eslint, stylelint
- [logstop](https://github.com/ankane/logstop) to avoid sensitive information and noise in the application logs
- [semantic_logger](https://github.com/reidmorrison/semantic_logger) as a highly configurable logging system
- [simplecov](https://github.com/simplecov-ruby/simplecov) for test coverage research
- announcements (new/fix/update) for all users
- flash helper
- referral system
- landing page
- custom error pages
- profiles controller
- admin and customer dashboards
- users administration with search

## Todo

- add [secure_headers](https://github.com/github/secure_headers)
- add [ssrf_filter](https://github.com/arkadiyt/ssrf_filter)
- add [devise-security](https://github.com/devise-security/devise-security)
- add [hotwire](https://hotwire.dev/)
- add [mailkick](https://github.com/ankane/mailkick)
- add [discard](https://github.com/jhawthorn/discard)
- add [invisible_captcha](https://github.com/markets/invisible_captcha)
- add [hypershield](https://github.com/ankane/hypershield)
- add [hairtrigger](https://github.com/jenseng/hair_trigger)
- add [ActiveRecordExtended](https://github.com/georgekaraszi/ActiveRecordExtended)
- add [scenic](https://github.com/scenic-views/scenic)
- add [hair_trigger](https://github.com/jenseng/hair_trigger)
- add [identity_cache](https://github.com/Shopify/identity_cache)
- move to [rails-settings-cached](https://github.com/huacnlee/rails-settings-cached)
- move to [turnip](https://github.com/jnicklas/turnip) from cucumber
- add [searchjoy](https://github.com/ankane/searchjoy)
- add [database_consistency](https://github.com/djezzzl/database_consistency)
- add [database_validations](https://github.com/toptal/database_validations)
- add [traceroute](https://github.com/amatsuda/traceroute)
- add [isolator](https://github.com/palkan/isolator)
- add [pronto](https://github.com/prontolabs/pronto)
- add [crystalball](https://github.com/toptal/crystalball)
- add [reek](https://github.com/troessner/reek) and [rubycritic](https://github.com/whitesmith/rubycritic)
- add [danger](https://danger.systems/)
- add [lit](https://github.com/prograils/lit)
- update with rails [production best practices](https://github.com/ankane/production_rails), [security best practices](https://github.com/ankane/secure_rails) and [rails-security-checklist](https://github.com/eliotsykes/rails-security-checklist)
- add [active_storage_validations](https://github.com/igorkasyanchuk/active_storage_validations)
- add tools from [evil martians tollbox](https://github.com/evilmartians/terraforming-rails)
- test and add [dawnscanner](https://github.com/thesp0nge/dawnscanner)
- add 2FA for admin accounts by default
- add feedback
- add monitoring and analytics tools
- add A11y
- add deployments tools
- add documentation (howto's, best practices, curated list of libraries)

## Known issues

nothing

## Contributing [![PRs welcome](https://img.shields.io/badge/PRs-welcome-orange.svg?style=flat-square)](https://github.com/alec-c4/kickstart/issues)

For bug fixes, documentation changes, and features:

1. [Fork it](./fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

For larger new features: Do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction.