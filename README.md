# EasyqaApi

The simple gem for EasyQA Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easyqa_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easyqa_api

## Usage
Login user on EasyQA 
```ruby
user = EasyqaApi::User.new(email: 'test@gmail.com', password: '1234567890')
```

And now you can do any action with easyqa_api. For example:
```ruby
organization = EasyqaApi::Organization.create({ title: 'Test', description: 'Test' }, user)
```

If you do not want to always point of the user during any action in easyqa_api - set it as default 
```ruby
user.set_default!
```

And now:
```ruby
organization = EasyqaApi::Organization.create(title: 'Test', description: 'Test')
```

Link to documentation
http://www.rubydoc.info/gems/easyqa_api/0.0.3/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thinkmobiles/easyqa_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

