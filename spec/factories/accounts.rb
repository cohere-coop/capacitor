# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, aliases: %i[client worker leader owner] do
    sequence(:email) { |i| "account-#{i}@example.com" }
    name "test"
    password "password"

    factory :account_who_checked_in_yesterday do
      after :create do |account, _evaluator|
        create :check_in, account: account, worked_at: 1.day.ago
      end
    end
  end
end
