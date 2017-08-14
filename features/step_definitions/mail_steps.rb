# frozen_string_literal: true

Then(/^I receive a (.*) email$/) do |email_kind|
  email_template = app.email_template(email_kind)
  received_emails = email_client.messages_where(to: app.current_account.email,
                                                subject: email_template.subject)

  raise "No '#{email_kind}' email to '#{app.current_account.email}'" if received_emails.empty?
end
