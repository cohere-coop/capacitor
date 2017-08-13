# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Capacitor
  # Main rails application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = "Central Time (US & Canada)"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join("my", "locales", "*.{rb,yml}").to_s]
    # config.i18n.default_locale = :de
    if ENV["SMTP_HOST"] && ENV["SMTP_USERNAME"] && ENV["SMTP_PASSWORD"]
      config.action_mailer.smtp_settings = {
        address: ENV["SMTP_HOST"],
        user_name: ENV["SMTP_USERNAME"],
        password: ENV["SMTP_PASSWORD"],
        port: ENV["SMTP_PORT"] || 25
      }
    end

    mail_options = { from: "hello@capacitorapp.com" }
    config.action_mailer.default_options = mail_options

    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join('lib')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.beginning_of_week = :sunday
    config.encoding = "utf-8"
  end
end
