# frozen_string_literal: true

require "missing_check_in_audit"
require "rails_helper"
require "timecop"
require "email_spec"

describe MissingCheckInAudit do
  it "does full combinatoric testing someday :/"

  before do
    ActionMailer::Base.deliveries.clear
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  around do |example|
    day_with_a_business_day_before_it = Time.zone.parse("Tuesday, March 13, 2018")
    Timecop.freeze(day_with_a_business_day_before_it) do
      example.run
    end
  end

  describe "running an audit" do
    include Rails.application.routes.url_helpers
    Given { default_url_options.merge!(Settings.url_options) }

    subject(:sent_email) { ActionMailer::Base.deliveries.last }

    Given!(:account_missing_check_in_on_day_audited) { FactoryGirl.create(:account) }
    Given!(:account_with_check_in_on_day_audited) do
      account = FactoryGirl.create(:account)
      # create the check-in at noon to be very sure this is a normal case rather than an edge case
      FactoryGirl.create(:check_in, account: account, worked_at: (Time.zone.today.beginning_of_day + 12.hours))
      account
    end
    # Accounts are up to date as of today
    Given!(:accounts_are_up_to_date_as_of_today) do
      FactoryGirl.create(:check_in,
                         account: account_missing_check_in_on_day_audited,
                         worked_at: (Date.yesterday.beginning_of_day + 12.hours))
      FactoryGirl.create(:check_in,
                         account: account_with_check_in_on_day_audited,
                         worked_at: (Date.yesterday.beginning_of_day + 12.hours))
    end

    When do
      audit = described_class.for_day(Time.zone.today)

      audit.proceed!
    end

    context "when the accounts have check in enabled" do
      Given do
        account_missing_check_in_on_day_audited.enable_feature(:check_in)
        account_with_check_in_on_day_audited.enable_feature(:check_in)
      end

      Then { ActionMailer::Base.deliveries.length == 1 }
      Then { sent_email.to == [account_missing_check_in_on_day_audited.email] }
      Then { sent_email.subject == "Let's check in your activities from #{Time.zone.today.to_s(:long_ordinal)}" }
      Then { sent_email.body.encoded.include? new_check_in_url }
    end

    context "when the accounts do not have check in enabled" do
      Given do
        account_missing_check_in_on_day_audited.disable_feature(:check_in)
        account_with_check_in_on_day_audited.disable_feature(:check_in)
      end

      Then { ActionMailer::Base.deliveries.empty? }
    end
  end

  context "running an audit against a single-hour time window" do
    include Rails.application.routes.url_helpers
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    before do
      default_url_options.merge!(Settings.url_options)
    end

    it "only sends reminders within the window" do
      account_with_earlier_reminder_time = FactoryGirl.create(:account, check_in_reminder_time: "5:00PM")
      account_with_reminder_time_in_window = FactoryGirl.create(:account, check_in_reminder_time: "6:00PM")
      up_to_date_account_with_reminder_time_in_window = FactoryGirl.create(:account, check_in_reminder_time: "6:00PM")
      account_with_later_reminder_time = FactoryGirl.create(:account, check_in_reminder_time: "7:00PM")

      date_audited = Date.yesterday

      # create the check-in at noon to be very sure this is a normal case rather than an edge case
      noon_on_date_audited = date_audited.beginning_of_day + 12.hours
      up_to_date_account_with_reminder_time_in_window.check_ins.create!(
        FactoryGirl.attributes_for(:check_in, worked_at: noon_on_date_audited)
      )

      audit = described_class.for_day_and_reminder_window(date_audited, "6:00PM")
      audit.proceed!

      email = mailbox_for(account_with_reminder_time_in_window.email).first
      expected_subject_line = "Let's check in your activities from #{Date.yesterday.to_s(:long_ordinal)}"
      aggregate_failures do
        expect(mailbox_for(account_with_earlier_reminder_time.email).size).to eq(0)
        expect(mailbox_for(account_with_reminder_time_in_window.email).size).to eq(1)
        expect(mailbox_for(up_to_date_account_with_reminder_time_in_window.email).size).to eq(0)
        expect(mailbox_for(account_with_later_reminder_time.email).size).to eq(0)

        expect(email).to have_subject(expected_subject_line)
      end
    end
  end

  context "multi-hour time windows" do
    include Rails.application.routes.url_helpers
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    before do
      default_url_options.merge!(Settings.url_options)
    end

    it "only sends reminders within the window" do
      account_with_earlier_reminder_time = FactoryGirl.create(:account, check_in_reminder_time: "5:00PM")
      account_with_reminder_time_in_window = FactoryGirl.create(:account, check_in_reminder_time: "6:00PM")
      up_to_date_account_with_reminder_time_in_window = FactoryGirl.create(:account, check_in_reminder_time: "6:00PM")
      account_with_other_reminder_time_in_window = FactoryGirl.create(:account, check_in_reminder_time: "7:00PM")
      account_with_later_reminder_time = FactoryGirl.create(:account, check_in_reminder_time: "8:00PM")

      date_audited = Date.yesterday

      # create the check-in at noon to be very sure this is a normal case rather than an edge case
      noon_on_date_audited = date_audited.beginning_of_day + 12.hours
      up_to_date_account_with_reminder_time_in_window.check_ins.create!(
        FactoryGirl.attributes_for(:check_in, worked_at: noon_on_date_audited)
      )

      audit = described_class.for_day_and_reminder_window(Date.yesterday, "6:00PM".."7:00PM")
      audit.proceed!

      account_in_window_email = mailbox_for(account_with_reminder_time_in_window.email).first
      other_account_in_window_email = mailbox_for(account_with_other_reminder_time_in_window.email).first
      expected_subject_line = "Let's check in your activities from #{Date.yesterday.to_s(:long_ordinal)}"
      aggregate_failures do
        expect(mailbox_for(account_with_earlier_reminder_time.email).size).to eq(0)
        expect(mailbox_for(account_with_reminder_time_in_window.email).size).to eq(1)
        expect(mailbox_for(account_with_other_reminder_time_in_window.email).size).to eq(1)
        expect(mailbox_for(up_to_date_account_with_reminder_time_in_window.email).size).to eq(0)
        expect(mailbox_for(account_with_later_reminder_time.email).size).to eq(0)

        expect(account_in_window_email).to have_subject(expected_subject_line)
        expect(other_account_in_window_email).to have_subject(expected_subject_line)
      end
    end
  end
end
