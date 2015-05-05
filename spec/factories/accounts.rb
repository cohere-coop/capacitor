# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, aliases: [:client, :worker] do
  	email "test@email.com"
  	password "password"
  end
end
