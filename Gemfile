# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.4.1"

gem "rails", "~> 5.2"

# Used for user authentication
gem "devise", "~> 4.3"
gem "doorkeeper", "~> 4.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"

# Exception tracking
gem "raygun4ruby"

# Use .haml for views
gem "haml-rails", "~> 1.0"

# Provides a wrapper object for models
gem "draper", "~> 3.0"

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

# time parsing
gem "chronic"

group :production do
  # A concurrent web server
  gem "puma", "~> 3.9"

  # This gem makes rack requests time out...because puma doesn't
  gem "rack-timeout", "~> 0.4"
end

group :development do
  # Allows auto-loading of files
  gem "listen"
  # Catches style issues
  gem "rubocop", "~> 0.48.0"

  # Specifically pulls in cops for rspec
  gem "rubocop-rspec", "~> 1.15"
end

group :development, :test do
  # Autoloads the .env file for secrets
  gem "dotenv-rails", "~> 2.2", require: "dotenv/rails-now"

  # Allows us to drop some binding.prs
  gem "byebug"
  gem "pry-byebug"
  gem "pry-rails", "~> 0.3.6"

  # Gives us fixtures
  gem "factory_girl_rails", "~> 4.8"
end

group :test do
  gem "simplecov", require: false
  # The rspec testing framework intergation for rails
  gem "rspec-rails", "~> 3.6"

  # Mailcatcher!
  gem "mailcatcher"

  # Feature testing!
  gem "cucumber"
  gem "site_prism"

  # Easy-ish Web testing!
  gem "capybara", "~> 2.4"
  gem "capybara-selenium"

  # Grants rspec Given/When/Then syntax
  gem "rspec-given", "~> 3.8"

  # Write validation tests cleanly
  gem "shoulda-matchers", "~> 3.1"

  gem "rspec_junit_formatter"

  # wibbley wobbley timey wimey
  gem "timecop"

  gem "email_spec"
end
