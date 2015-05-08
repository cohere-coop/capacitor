# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :capacity do
    amount 1
    quality 1
    worked_at "2015-04-30"
    project
    worker
  end
end
