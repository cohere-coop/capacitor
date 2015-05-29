class AccountDecorator < Draper::Decorator
  delegate_all

  def recent_logs
    logs.recent.decorate
  end
end
