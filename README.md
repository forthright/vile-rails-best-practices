# vile-rails-best-practices [![Circle CI](https://circleci.com/gh/forthright/vile-rails-best-practices.svg?style=shield&circle-token=fd1583c63da595c1c2dc380fe0118229c2f521ba)](https://circleci.com/gh/forthright/vile-rails-best-practices) [![score-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/score?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![security-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/security?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![coverage-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/coverage?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![dependency-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/dependency?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices)

A [Vile](https://vile.io) plugin for identifying common style and
maintainability issues in your Rails code (via [rails_best_practices](https://github.com/railsbp/rails_best_practices)).

## Requirements

- [Node.js](http://nodejs.org)
- [Ruby](http://ruby-lang.org)

## Installation

Currently, you need to have `rails_best_practices` installed manually.

    npm i -D vile vile-rails-best-practices
    gem install rails_best_practices

A good strategy is to use [Bundler](http://bundler.io).

## Config

```yaml
rails-best-practices:
  config:
    vendor: true
    spec: true
    test: true
    features: true
```

## Ignorning Files

You can use `vile.ignore` or set `rails_best_practices.ignore`:

```yaml
rails-best-practices:
  ignore:
    - spec
```

You can also set the cli specific `exclude` option:

```yaml
rails-best-practices:
  config:
    exclude:
      - foo/bar
      - baz
```

## Allowing Files

You can use `vile.allow` or set `rails_best_practices.allow`:

```yaml
rails-best-practices:
  allow:
    - app/controllers
```

You can also set the cli specific `path` option:

```yaml
rails-best-practices:
  config:
    path:
      - foo/bar
      - baz
```

## Setting Path Arg

You can set the cli specific `path` arg if you want:
```yaml
rails-best-practices:
  config:
    path: "."
```

## Versioning

This project uses [Semver](http://semver.org).

## Licensing

This project is licensed under the [MPL-2.0](LICENSE) license.

Any contributions made to this project are made under the current license.

## Contributions

Current list of [Contributors](https://github.com/forthright/vile-rails-best-practices/graphs/contributors).

Any contributions are welcome and appreciated!

All you need to do is submit a [Pull Request](https://github.com/forthright/vile-rails-best-practices/pulls).

1. Please consider tests and code quality before submitting.
2. Please try to keep commits clean, atomic and well explained (for others).

### Issues

Current issue tracker is on [GitHub](https://github.com/forthright/vile-rails-best-practices/issues).

Even if you are uncomfortable with code, an issue or question is welcome.

### Code Of Conduct

By participating in this project you agree to our [Code of Conduct](CODE_OF_CONDUCT.md).

### Maintainers

- Brent Lintner - [@brentlintner](http://github.com/brentlintner)

## Architecture

This project is currently written in JavaScript. `rails_best_practices` provides
a JSON CLI output that is currently used until a more ideal option is implemented.

- `bin` houses any shell based scripts
- `src` is es6+ syntax compiled with [Babel](https://babeljs.io)
- `lib` generated js library

## Developing

    cd vile-rails-best-practices
    npm install
    npm run dev
    npm test
