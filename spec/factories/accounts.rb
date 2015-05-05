# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, aliases: [:client, :worker] do
  	sequence(:email) { |i| "account-#{i}@example.com" }
  	password "password"
  end
end
