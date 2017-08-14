# frozen_string_literal: true

# Base mailer from which all things are inherited from
class ApplicationMailer < ActionMailer::Base
  default from: "hello@#{Settings.app_domain}"
  layout "mailer"
end
