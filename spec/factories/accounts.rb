# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, aliases: [:client, :worker, :leader, :owner] do
    sequence(:email) { |i| "account-#{i}@example.com" }
    name "test"
    password "password"
  end
end
