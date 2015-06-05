# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    amount 1
    quality 1
    worked_at "2015-04-30"
    do_not_bill false
    project
    account
    factory :recent_log do
      worked_at 3.days.ago
    end

    factory :old_log do
      worked_at 8.days.ago
    end
  end
end
