# frozen_string_literal: true

# Plain old ruby object that can stand in as the account model for our feature
# tests
class Account
  attr_accessor :email, :name, :password, :captured_emails
  def initialize(email: nil, name: nil, password: nil)
    self.email = email
    self.name = name
    self.password = password
    self.captured_emails = []
  end

  def capture_and_tag_emails(email_client:, **tags)
    existing_messages = email_client.messages_for(email)
    yield
    new_messages = email_client.messages_for(email) - existing_messages
    new_messages.each do |message|
      message[:tags] = tags
    end
    captured_emails.concat(new_messages)
  end

  def emails_tagged_with(**tags)
    captured_emails.select do |email|
      tags <= email[:tags]
    end
  end
end
