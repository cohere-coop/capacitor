class AccountDecorator < Draper::Decorator
  delegate_all

  def recent_logs
    logs.recent.decorate
  end

  def weekly_expected_capacity
    logs.pluck(:amount).sum
    account.weekly_expected_capacity
  end

  def remaining_personal_capacity
    logs.pluck(:amount).sum
    account.weekly_expected_capacity
  end
end
