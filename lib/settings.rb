# frozen_string_literal: true

# Encapsulates configuration
module Settings
  def self.configure_rails(config)
    # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
    config.force_ssl = app_server_force_ssl?
    configure_action_mailer(config)
  end

  def self.app_domain
    if ENV["APP_DOMAIN"]
      ENV["APP_DOMAIN"]
    else
      "#{ENV['HEROKU_APP_NAME']}.herokuapp.com"
    end
  end

  def self.app_status_url
    "#{app_url}/status"
  end

  def self.app_url
    url = "#{app_protocol}://#{app_domain}"
    url += ":#{app_server_port}" if app_server_port?
    url
  end

  def self.app_protocol
    app_server_force_ssl? ? "https" : "http"
  end

  def self.app_server_port
    ENV.fetch("PORT", 3000)
  end

  def self.app_server_port?
    app_server_port.present?
  end

  def self.app_server_environment
    ENV.fetch("RACK_ENV") { "development" }
  end

  def self.app_server_development?
    app_server_environment == "development"
  end

  def self.app_server_concurrency
    ENV.fetch("WEB_CONCURRENCY") { 2 }
  end

  def self.app_server_max_threads
    ENV.fetch("RAILS_MAX_THREADS") { 5 }
  end

  # Force SSL unless force SSL is exactly set to false
  def self.app_server_force_ssl?
    ENV.fetch("APP_SERVER_FORCE_SSL", "true") != "false"
  end

  def self.url_options
    url_options = { host: app_domain,
                    protocol: app_protocol }
    url_options[:port] = app_server_port if app_server_development?
    url_options
  end

  def self.configure_action_mailer(config)
    config.action_mailer.default_url_options = url_options

    config.action_mailer.smtp_settings = {
      address: smtp_host,
      user_name: ENV["SMTP_USERNAME"],
      password: ENV["SMTP_PASSWORD"],
      port: smtp_port
    }
  end

  def self.smtp_status_url
    "http://#{smtp_host}:1080"
  end

  def self.smtp_host
    ENV["SMTP_HOST"]
  end

  def self.smtp_port
    ENV.fetch("SMTP_PORT", 25)
  end
end
