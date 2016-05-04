require "missing_check_in_notifier"
require "rails_helper"

describe MissingCheckInNotifier do
  before do
    ActionMailer::Base.deliveries.clear
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  describe ".notify" do
    include Rails.application.routes.url_helpers
    Given { default_url_options[:host] = "example.com" }
    Given!(:account_without_check_in_yesterday) { FactoryGirl.create(:account) }
    Given!(:account_who_checked_in_yesterday) { FactoryGirl.create(:account_who_checked_in_yesterday) }

    let(:sent_email) { ActionMailer::Base.deliveries.last }

    context "when the accounts have check in enabled" do
      Given do
        account_without_check_in_yesterday.enable_feature(:check_in)
        account_who_checked_in_yesterday.enable_feature(:check_in)
      end

      When { described_class.notify }

      Then { ActionMailer::Base.deliveries.length == 1 }
      Then { sent_email.to == [account_without_check_in_yesterday.email] }
      Then { sent_email.subject == "Let's check in your activities from #{1.day.ago.to_date.to_s(:long_ordinal)}" }
      Then { sent_email.body.encoded.include? new_check_in_url }
    end

    context "when the accounts do not have check in enabled" do
      Given do
        account_without_check_in_yesterday.disable_feature(:check_in)
        account_who_checked_in_yesterday.disable_feature(:check_in)
      end

      When { described_class.notify }

      Then { ActionMailer::Base.deliveries.length == 0 }
    end
  end
end
