# sidekiq_admin_enquerer

---

- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
- [License](#license)
- [Authors](#authors)

# TODO:

- job invocation form redesign;
- interactive UI tabs for each performing method (sidekiq's UI has no jquery and bootstrap-js integrations);
- job invocation rework (support for kwarg invocation and analysis of passed attributes);
- specs;

## Installation

```ruby
gem 'sidekiq_admin_enquerer'
```

```shell
bundle install
# --- or ---
gem install sidekiq_admin_enquerer
```

```ruby
require 'sidekiq_admin_enquerer'
```

## Usage

- it is assumed that you are using `Rails`;

```ruby
# config/initializers/sidekiq.rb

# ...your sidekiq configs...

SidekiqAdminEnqueuer.load
```

- navigate to `/your-sidekiq-path/enqueuer`

---

## Development

- full build (`rubocop` => `rspec`)

```shell
bundle exec rake
```

- code style check (`rubocop`):

```shell
bundle exec rake rubocop
```

- tests (`rspec`):

```shell
bundle exec rake rspec
```

## License

Released under MIT License.

## Authors

[Rustam Ibragimov](https://github.com/0exp)
