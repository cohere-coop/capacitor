# frozen_string_literal: true

# Encapsulates configuration
module Settings
  def self.app_host
    if ENV["APP_DOMAIN"]
      ENV["APP_DOMAIN"]
    else
      "#{ENV['HEROKU_APP_NAME']}.herokuapp.com"
    end
  end
end
