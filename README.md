# Kickstart

There are a collection of application templates, scripts, and automatizations I use for everyday work. All included code is written with the following principles:
- Code is testable
- Code is written to be supported without a hassle
- Code is written, following best practices from developers and product communities

Feel free to submit any feature or pull request if you think that it may be useful for the community.

## Usage instructions

### Monolith ruby on rails application with tailwindcss frontend

```bash
rails new APP_NAME --no-skip-hotwire -T -c tailwind -j esbuild -d postgresql -m https://raw.githubusercontent.com/alec-c4/ks-rails-tailwind/master/template.rb
```
### Monolith ruby on rails application with bootstrap frontend
```bash
rails new APP_NAME --no-skip-hotwire -T -c bootstrap -j esbuild -d postgresql -m https://raw.githubusercontent.com/alec-c4/ks-rails-bootstrap/master/template.rb
```

## Available templates

- [Monolith ruby on rails application with tailwindcss frontend](https://github.com/alec-c4/ks-rails-tailwind)
- [Monolith ruby on rails application with bootstrap frontend](https://github.com/alec-c4/ks-rails-bootstrap)

## Todo

- Add monolith ruby on rails template with [inertia.js](https://inertiajs.com) frontend
- Add Nest.js template
- Add Svelte/SvelteKit templates
- Add ansible templates for rails and js applications
- Add terraform templates for DigitalOcean, Linode and AWS


## Known issues

not found

## Contributing [![PRs welcome](https://img.shields.io/badge/PRs-welcome-orange.svg?style=flat-square)](https://github.com/alec-c4/kickstart/issues)

For bug fixes, documentation changes, and features:

1. [Fork it](./fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

For larger new features: Do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction.