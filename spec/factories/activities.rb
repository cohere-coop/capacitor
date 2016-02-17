# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    sequence(:name) { |i| "Activity #{i}" }
    capacity 15
    weekly_burn_rate 4
    billable true
  end
end
