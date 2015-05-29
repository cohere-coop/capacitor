class LogDecorator < Draper::Decorator
  delegate_all

  def summary
    "#{project.name}, #{amount}, #{worked_at}"
  end

  def dom_id
    "log-#{project.id}"
  end
end
