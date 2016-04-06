require "missing_check_in_notifier"
require "rails_helper"

describe MissingCheckInNotifier do
  describe ".notify" do
    include Rails.application.routes.url_helpers
    When { default_url_options[:host] = "example.com" }
    Given!(:account_without_check_in_yesterday) { FactoryGirl.create(:account) }
    Given!(:account_who_checked_in_yesterday) { FactoryGirl.create(:account_who_checked_in_yesterday) }
    Given(:sent_email) { ActionMailer::Base.deliveries.last }

    When { described_class.notify }

    Then { ActionMailer::Base.deliveries.length == 1 }
    Then { sent_email.to == [account_without_check_in_yesterday.email] }
    Then { sent_email.subject == "Let's check in your activities from #{1.day.ago.to_date.to_s(:long_ordinal)}" }
    Then { sent_email.body.encoded.include? new_check_in_url }
  end
end
