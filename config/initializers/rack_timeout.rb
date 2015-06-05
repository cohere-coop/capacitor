Rack::Timeout.timeout = Integer(ENV["RACK_TIMEOUT"] || 20)
Rack::Timeout.unregister_state_change_observer(:logger) if Rails.env.development?
