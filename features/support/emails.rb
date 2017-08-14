# frozen_string_literal: true

require_relative "registry"

# "Page Object" like thing for emails...
class Email
  def self.reference_as
    name.gsub("Email", "")
  end

  def self.inherited(child)
    registry.add(child.reference_as, child)
  end

  def self.registry
    @registry ||= Registry.new
  end
end

# Useful for asserting that an email that matches the
# particular template was actually sent
class RegistrationWelcomeEmail < Email
  def subject
    "Welcome To Capacitor!"
  end
end
