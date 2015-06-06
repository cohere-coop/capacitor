class AccountDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def recent_logs
    LogDecorator.decorate_collection(logs.recent)
  end

  def weekly_expected_capacity
    account.weekly_expected_capacity.to_business_days
  end

  def remaining_personal_capacity
    account.remaining_personal_capacity.to_business_days
  end
end
