# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.2] - 2025-01-15

### Added

- [better_html](https://github.com/Shopify/better-html) gem with spec
- [erb_lint](https://github.com/Shopify/erb_lint) gem
- [mission_control-jobs](https://github.com/rails/mission_control-jobs/) gem
- [active_interaction](https://github.com/AaronLasseigne/active_interaction) gem
- [anyway_config](https://github.com/palkan/anyway_config) gem
- [madmin](https://github.com/excid3/madmin/) gem
- [pagy](https://github.com/ddnexus/pagy) gem with official initializer
- [active_decorator](https://github.com/amatsuda/active_decorator) gem
- [shrine](https://github.com/shrinerb/shrine) gem for file uploads
- [lockbox](https://github.com/ankane/lockbox) and [blind_index](https://github.com/ankane/blind_index) for encryption
- [view_component](https://github.com/ViewComponent/view_component) gem with Lookbook for frontend templates
- [parallel_tests](https://github.com/grosser/parallel_tests)
- custom settings file - `config/settings.yml`
- static pages - home, about, terms and privacy
- application helpers for common view patterns

### Fixed

- `anyway_config` rubocop warning for `@instance ||= new` pattern

## [1.0.1] - 2024-09-15

### Added

- Template management system

### Fixed

- Remote template execution issue

## [1.0.0] - 2024-09-01

### Added

- Initial project setup
- API template
- Minimal template based on importmaps
- Esbuild/Tailwind template
- Shell-script to create rails app with pre-configured options

[Unreleased]: https://github.com/alec-c4/kickstart/compare/v1.0.2...master
[1.0.2]: https://github.com/alec-c4/kickstart/releases/tag/v1.0.2
[1.0.1]: https://github.com/alec-c4/kickstart/releases/tag/v1.0.1
[1.0.0]: https://github.com/alec-c4/kickstart/releases/tag/v1.0.0
