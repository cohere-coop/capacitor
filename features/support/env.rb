# frozen_string_literal: true

require "capybara/cucumber"
require "selenium-webdriver"
require "site_prism"
require "pry"
require "byebug"
require "factory_girl"
require "active_support"
require "active_support/core_ext"
require "settings"
require "dotenv"

ENV.delete("RAILS_ENV")
ENV.delete("RACK_ENV")

root = Pathname.new(Dir.pwd)
Dotenv.load(root.join(".env.development.local"), root.join(".env.development"),
            root.join(".env"))
require_relative "account"
require_relative "app"

World(App::Helper)
FactoryGirl.find_definitions

Capybara.app_host = Settings.app_url

Before do
  WaitForUp.new(Settings.smtp_status_url, name: "Mail API", hint: "Is mailcatcher running?").wait
  WaitForUp.new(Settings.app_status_url, name: "Rails App").wait
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome
