# vile-rails-best-practices [![Circle CI](https://circleci.com/gh/forthright/vile-rails-best-practices.svg?style=shield&circle-token=fd1583c63da595c1c2dc380fe0118229c2f521ba)](https://circleci.com/gh/forthright/vile-rails-best-practices)

[![score-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/score?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![security-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/security?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![coverage-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/coverage?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices) [![dependency-badge](https://vile.io/api/v0/projects/vile-rails-best-practices/badges/dependency?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-rails-best-practices)

A [vile](https://vile.io) plugin for [rails_best_practices](http://rails-bestpractices.com).

## Requirements

- [nodejs](http://nodejs.org)
- [npm](http://npmjs.org)
- [ruby](http://ruby-lang.org)
- [rubygems](http://rubygems.org)

## Installation

Currently, you need to have `rails_best_practices` installed manually.

A good strategy is to use [bundler](http://bundler.io).

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

## Architecture

This project is currently written in JavaScript. `rails_best_practices` provides
a JSON CLI output that is currently used until a more ideal option is implemented.

- `bin` houses any shell based scripts
- `src` is es6+ syntax compiled with [babel](https://babeljs.io)
- `lib` generated js library

## Hacking

    cd vile-rails-best-practices
    npm install
    npm run dev
    npm test
