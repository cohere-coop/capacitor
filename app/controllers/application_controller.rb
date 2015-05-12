class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def track_event(event_name)
    # Cookies must always be stored as strings.
    analytics = (cookies[:analytics] ? JSON.parse(cookies[:analytics], symbolize_names: true) : {})

    # analytics[:uuid] = current_account.uuid if current_account
    analytics[:events] ||= []
    analytics[:events].push({ name: event_name })

    # Convert the analytics object back into a string so it can stay in the
    # cookie
    # { uuid: 1234, events: [ { name: "awesome event" } ] }
    cookies[:analytics] = JSON.dump(analytics)
  end
end
