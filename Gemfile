source "https://rubygems.org"

gem "rails", "4.2.0"

# Used for user authentication
gem "devise", "3.4.1"

# Use postgresql as the database for Active Record
gem "pg", "0.18.2"

# Use .haml for views
gem "haml", "4.0.6"

# Use SCSS for stylesheets
gem "sass-rails", "5.0.3"

# Use jquery as the JavaScript library
gem "jquery-rails", "4.0.3"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "1.3.0"

# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "0.4.0", group: :doc

# Used to catch errors in production
gem "bugsnag", "2.8.6"

group :production do
  # Does some special heroku magic
  gem "rails_12factor", "0.0.3"

  # A concurrent web server
  gem "puma", "2.11.3"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", "5.0.0"

  # Autoloads the .env file for secrets
  gem "dotenv-rails", "2.0.1"

  # The rspec testing framework intergation for rails
  gem "rspec-rails", "3.2.0"

  # Allows for easy testing of the web
  gem "capybara", "2.4.4"

  # Lets capybara take screenshots of tests
  gem "capybara-screenshot", "1.0.0"

  # Gives us fixtures
  gem "factory_girl_rails", "4.5.0"

  # Allows for special Given/When/Then syntax
  gem "rspec-given", "3.5.0"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "2.0.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "1.3.6"

  # Catches style issues
  gem "rubocop", "0.31.0"

  # Specifically pulls in cops for rspec
  gem "rubocop-rspec", "1.3.0"
end

gem "bourbon"
gem "neat"
gem "bitters"
