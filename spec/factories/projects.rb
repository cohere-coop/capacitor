# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "Project #{i}" }
    client
    total 15
    used 0
    remaining 0
  end
end
