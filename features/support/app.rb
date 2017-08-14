# frozen_string_literal: true

require_relative "email_client"
require_relative "emails"
require_relative "pages"
require_relative "session"

# Aggregates the session, pages, emails, etc. into an object
# instead of spewing things all over the global state.
class App
  # Expose app to the Cucumber
  module Helper
    def app
      @app ||= App.new
    end

    def email_client
      @email_client ||= EmailClient.new
    end
  end
  attr_accessor :current_page

  def email_template(name)
    emails.get(name).new
  end

  def emails
    Email.registry
  end

  def visit_page(name)
    self.current_page = page(name)
    current_page.load
  end

  def page(name)
    pages.get(name).new(session)
  end

  def pages
    Page.registry
  end

  def session
    @session ||= Session.new
  end

  delegate :current_account, to: :session
end
