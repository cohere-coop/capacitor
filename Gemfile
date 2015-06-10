source "https://rubygems.org"

ruby "2.2.2"

gem "rails", "4.2.1"

# Used for user authentication
gem "devise", "3.4.1"

# Use postgresql as the database for Active Record
gem "pg", "0.18.2"

# Use .haml for views
gem "haml", "4.0.6"

# Provides a wrapper object for models
gem "draper", "1.4.0"

# Use SCSS for stylesheets
gem "sass-rails", "5.0.3"

# Use jquery as the JavaScript library
gem "jquery-rails", "4.0.3"

gem "jquery-ui-rails", "5.0.5"

gem "segment_rails", "0.2.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "2.7.1"

# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "0.4.0", group: :doc

# Used to catch errors in production
gem "bugsnag", "2.8.6"

# A lightweight compass alternative
gem "bourbon", "4.2.3"

# Hooray for grid systems!
gem "neat", "1.7.2"

# And some basic prettiness
gem "bitters", "1.0.0"

gem "pry-rails"

group :production do
  # Does some special heroku magic
  gem "rails_12factor", "0.0.3"

  # A concurrent web server
  gem "puma", "2.11.3"

  # This gem makes rack requests time out...because puma doesn't
  gem "rack-timeout", "0.2.4"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", "5.0.0"

  # Autoloads the .env file for secrets
  gem "dotenv-rails", "2.0.1"

  # The rspec testing framework intergation for rails
  gem "rspec-rails", "3.2.1"

  # Allows for easy testing of the web
  gem "capybara", "2.4.4"

  # Lets capybara take screenshots of tests
  gem "capybara-screenshot", "1.0.9"

  # Gives us fixtures
  gem "factory_girl_rails", "4.5.0"

  # Allows for special Given/When/Then syntax
  gem "rspec-given", "3.5.0"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "2.1.2"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "1.3.6"

  # Catches style issues
  gem "rubocop", "0.31.0"

  # Specifically pulls in cops for rspec
  gem "rubocop-rspec", "1.3.0"

  # This turns off the noisy asset logs
  gem "quiet_assets"
end
