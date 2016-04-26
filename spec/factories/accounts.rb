# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, aliases: [:client, :worker, :leader, :owner] do
    sequence(:email) { |i| "account-#{i}@example.com" }
    name "test"
    password "password"

    factory :account_who_checked_in_yesterday do
      after :create do |account, _evaluator|
        create :check_in, account: account, worked_at: 1.day.ago

        factory :account_with_check_in_disabled do
          account.features.check_in = false
        end
      end
    end
  end
end
