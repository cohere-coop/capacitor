FactoryGirl.define do
  factory :check_in, { aliases: [:recent_check_in] } do
    account
    worked_at 1.day.ago.beginning_of_day + 4.hours
  end

  factory :old_check_in do
    account
    worked_at 8.days.ago.beginning_of_day
  end
end
