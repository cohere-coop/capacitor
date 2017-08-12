# frozen_string_literal: true

# Email sent when missing check in after a day
class MissingCheckInMailer < ActionMailer::Base
  def missing_check_in(account, date_to_check_in)
    @account = account
    @friendly_date = date_to_check_in.to_date.to_formatted_s(:long_ordinal)
    mail(to: account.email, subject: "Let's check in your activities from #{@friendly_date}")
  end
end
