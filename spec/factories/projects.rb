# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "Project #{i}" }
    capacity 15
    capacity_logged 0
  end
end
