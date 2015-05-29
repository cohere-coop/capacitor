require "capacity_converter"
class LogDecorator < Draper::Decorator
  delegate_all
  include CapacityConverter

  def summary
    "#{project.name}, #{amount}, #{worked_at}"
  end

  def amount
    to_days(log.amount)
  end

  def dom_id
    "log-#{project.id}"
  end
end
