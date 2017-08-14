# frozen_string_literal: true

# Email sent to welcome a new user
class RegistrationMailer < ApplicationMailer
  def welcome_email(account)
    mail(to: account.email, subject: "Welcome To Capacitor!")
  end
end
