FactoryGirl.define do
  factory :check_in do
    account
    worked_at 1.day.ago.beginning_of_day + 4.hours
  end
end
