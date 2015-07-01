# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "Project #{i}" }
    capacity 15
    weekly_burn_rate 4
    billable true
    factory :projects do
      transient do
        projects_count 5
      end
      after(:create) do |teams, evaluator|
        create_list(:projects, evaluator.projects_count, teams: teams)
      end
    end
  end
end
