require "capacity_converter"
class LogDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def summary
    "#{project.name}, #{amount}, #{worked_at}"
  end

  def amount
    log.amount.to_days
  end

  def dom_id
    "log-#{project.id}"
  end
end
