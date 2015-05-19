# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "Project #{i}" }
    client
    total_capacity_owed 15
    capacity_used 0
    capacity_remaining 0
  end
end
