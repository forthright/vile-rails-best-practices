# vile-rails-best-practices

A [vile](http://github.com/brentlintner/vile)
plugin for [rails_best_practices](http://rails-bestpractices.com).

## Requirements

- [nodejs](http://nodejs.org)
- [npm](http://npmjs.org)
- [ruby](http://ruby-lang.org)
- [rubygems](http://rubygems.org)

## Installation

Currently, you need to have `rails_best_practices` installed manually.

A good strategy is to use [bundler](http://bundler.io).

## Config

```yml
rails-best-practices:
  config:
    path: "."
```

```yml
rails-best-practices:
  config:
    only: "app" || [ "app", "spec" ]
```

```yml
rails-best-practices:
  config:
    exclude: "foo" || [ "foo", "bar" ]
```

```yml
rails-best-practices:
  config:
    vendor: true
    spec: true
    test: true
    features: true
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
