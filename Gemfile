source 'https://rubygems.org'

gem 'rails', '4.2.0'

gem 'bourbon'
gem 'neat'
gem 'bitters'

# Used to catch errors in production
gem 'bugsnag'

# Used for user authentication
gem 'devise'

# Use postgresql as the database for Active Record
gem 'pg'

# Use .haml for views
gem 'haml'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


group :production do
  # Does some special heroku magic
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Autoloads the .env file for secrets
  gem 'dotenv-rails', '2.0.1'

  gem 'rspec-rails', '~> 3.0'

  # Allows for easy testing of the web
  gem 'capybara'

  # Lets capybara take screenshots of tests
  gem 'capybara-screenshot', '~> 1.0'

  # Gives us fixtures
  gem 'factory_girl_rails'

  # Allows for special Given/When/Then syntax
  gem 'rspec-given', '~> 3.5'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Catches style issues
  gem 'rubocop', require: false
end
