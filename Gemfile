source 'https://rubygems.org'
ruby '2.0.0'

# Ruby itself doesn't require a JS runtime, but a default new Rails application does
#gem 'therubyracer' , require: "v8"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Bootstrap, a framework from Twitter that makes it easy to add nice web design and user interface
# elements to an HTML5 application
gem 'bootstrap-sass', '2.3.2.2'

# Using bcrypt to irreversibly encrypt the password to form the password has.
gem 'bcrypt-ruby', '~> 3.0.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.16.0'

group :development, :test do
    gem 'rspec-rails', "~> 2.14.0"
end

group :test do
    gem "selenium-webdriver", "~> 2.35.1"
    gem "capybara", "~> 2.1.0"
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.3.20',require: false
end

group :production do
    gem "unicorn", "~> 4.6.3"
    gem "rails_12factor", "~> 0.0.2"
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
