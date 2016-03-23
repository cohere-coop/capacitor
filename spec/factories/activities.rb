# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    sequence(:name) { |i| "Activity #{i}" }
    capacity 15
    weekly_burn_rate 4
    billable true
    owner

    factory :archived_activity do
      sequence(:name) { |i| "Archived Activity #{i}" }
      active false
    end
  end
end
