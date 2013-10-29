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

gem 'devise', '~> 3.1.0'

gem 'figaro', '~> 0.7.0'

gem "simple_form", "~> 3.0.0"

gem "tlsmail", "~> 0.0.1"

gem "nokogiri", "~> 1.6.0"



group :development, :test do
    gem 'rspec-rails', "~> 2.14.0"
    gem 'factory_girl_rails', '~> 4.2.1'    
end

group :test do
    gem "selenium-webdriver", "~> 2.35.1"
    gem "capybara", "~> 2.1.0"

    # Active record can be used to create a user with User.create
    # but user factories are a more convenient way to define 
    # user objects and insert them in the database.
    # Factory girl ruby gem generate factories
    # All factory girl factories are placed in spec/factories.rb.
    # It automatically gets loaded by Rspec.

    gem 'database_cleaner', '~> 1.1.1'
    gem 'email_spec', '~> 1.5.0'
    gem 'cucumber-rails', '~> 1.4.0',:require => false
    gem 'launchy', '~> 2.3.0'
end

group :development do
    gem 'quiet_assets', '~> 1.0.2'
    gem 'better_errors', '~> 1.0.1'
    gem 'binding_of_caller', '~> 0.7.2'
    gem "rails-erd", "~> 1.1.0"
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
