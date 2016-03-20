source "https://rubygems.org"

ruby "2.2.4"

gem "rails", "~> 4.2"

# Autoloads the .env file for secrets
gem "dotenv-rails", "~> 2.0", require: "dotenv/rails-now", group: [:development, :tes]

# Used for user authentication
gem "devise", "~> 3.5"

# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"

# Use .haml for views
gem "haml", "~> 4.0"

# Provides a wrapper object for models
gem "draper", "~> 1.4"

# ActiveModel on steroids!
gem "virtus", "~> 1.0"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"

# Use jquery as the JavaScript library
gem "jquery-rails", "~> 4.1"

gem "jquery-ui-rails", "~> 5.0"

gem "segment_rails", "0.2.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "~> 2.7"

# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4", group: :doc

# A lightweight compass alternative
gem "bourbon", "~> 4.2"

# Hooray for grid systems!
gem "neat", "~> 1.7"

# And some basic prettiness
gem "bitters", "1.2.0"

group :production do
  # Does some special heroku magic
  gem "rails_12factor", "0.0.3"

  # A concurrent web server
  gem "puma", "~> 2.11"

  # This gem makes rack requests time out...because puma doesn't
  gem "rack-timeout", "~> 0.3"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in
  # views
  gem "web-console", "~> 2.1"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "~> 1.3"

  # Catches style issues
  gem "rubocop", "0.37.2"

  # Specifically pulls in cops for rspec
  gem "rubocop-rspec", "~> 1.3"
end

group :development, :test do
  gem "codeclimate-test-reporter", group: :test, require: nil

  gem "pry-rails"

  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", "~> 5.0"

  # The rspec testing framework intergation for rails
  gem "rspec-rails", "~> 3.2"

  # Allows for easy testing of the web
  gem "capybara", "~> 2.4"

  # Lets capybara take screenshots of tests
  gem "capybara-screenshot", "~> 1.0"

  # Gives us fixtures
  gem "factory_girl_rails", "~> 4.5"

  # Allows for special Given/When/Then syntax
  gem "rspec-given", "~> 3.5"

  # This turns off the noisy asset logs
  gem "quiet_assets"
end
