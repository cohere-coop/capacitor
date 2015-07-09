# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    amount 1
    quality 1
    worked_at 5.days.ago
    do_not_bill false
    project
    account
    factory :recent_log do
      worked_at Time.zone.today
    end

    factory :old_log do
      worked_at 8.days.ago
    end
  end
end
