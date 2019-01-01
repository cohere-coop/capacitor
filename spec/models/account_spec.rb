# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  describe "check_in_reminder_time attribute" do
    describe "translates check_in_reminder_hour to a string" do
      let(:account) { Account.new }

      specify "for AM times" do
        account.check_in_reminder_hour = 3
        expect(account.check_in_reminder_time).to eq(TimeOfDay.from_string("3:00AM"))
      end

      specify "for PM times" do
        account.check_in_reminder_hour = 17
        expect(account.check_in_reminder_time).to eq(TimeOfDay.from_string("5:00PM"))
      end

      specify "for midnight" do
        account.check_in_reminder_hour = 0
        expect(account.check_in_reminder_time).to eq(TimeOfDay.from_string("12:00AM"))
      end
    end

    describe "translates incoming strings to check_in_reminder_hour integers" do
      let(:account) { Account.new }

      specify "for AM times" do
        account.check_in_reminder_time = "3:00AM"
        expect(account.check_in_reminder_hour).to eq(3)
      end

      specify "for PM times" do
        account.check_in_reminder_time = "5:00PM"
        expect(account.check_in_reminder_hour).to eq(17)
      end

      specify "for midnight" do
        account.check_in_reminder_time = "12:00AM"
        expect(account.check_in_reminder_hour).to eq(0)
      end
    end
  end
end
