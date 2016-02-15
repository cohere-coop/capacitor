# ViewModel for Account object
class AccountDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def recent_logs
    logs.recent.decorate
  end

  def weekly_expected_capacity
    account.weekly_expected_capacity.to_business_days
  end

  def remaining_weekly_capacity
    account.remaining_weekly_capacity.to_business_days
  end

  def remaining_recent_capacity
    account.remaining_recent_capacity.to_business_days
  end
end
