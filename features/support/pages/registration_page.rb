# frozen_string_literal: true

# Represents the registration page
# for feature testing purposes
class RegistrationPage < Page
  set_url "/accounts/sign_up"

  element :name_field, "#account_name"
  element :email_field, "#account_email"
  element :password_field, "#account_password"
  element :confirm_password_field, "#account_password_confirmation"
  element :submit, "input[name='commit']"

  def register(account)
    fill_in_registration_form(name: account.name,
                              email: account.email,
                              password: account.password)
    submit.click
    session.current_account = account
  end

  def fill_in_registration_form(name:, email:, password:)
    name_field.set(name)
    email_field.set(email)
    password_field.set(password)
    confirm_password_field.set(password)
  end
end
