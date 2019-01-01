# frozen_string_literal: true

# Allows us to retrieve emails for a particular person.
class EmailClient
  delegate :messages_where, :messages_for, to: :adapter

  def adapter
    @adapter ||= MailCatcherAdapter.new
  end

  # Adapter to retrieve emails from mailcatcher. May want to
  # replace this with SES for CircleCI or something? Or maybe
  # ActionMailer for non-black box tests?
  class MailCatcherAdapter
    def get(path)
      Net::HTTP.get(URI("http://127.0.0.1:1080/#{path}"))
    end

    def messages_where(to:, subject:)
      matching_messages = messages.select do |message|
        message[:recipients].include?(to) && message[:subject] == subject
      end
      matching_messages.map(&method(:merge_email_content))
    end

    def messages_for(to)
      matching_messages = messages.select do |message|
        message[:recipients].include?(to)
      end
      matching_messages.map(&method(:merge_email_content))
    end

    def merge_email_content(email)
      email.merge(text_content: message("#{email[:id]}.plain"),
                  html_content: message("#{email[:id]}.html"))
    end

    def messages
      JSON.parse(get("messages"), symbolize_names: true)
    end

    def message(id)
      get("messages/#{id}")
    end
  end
end
