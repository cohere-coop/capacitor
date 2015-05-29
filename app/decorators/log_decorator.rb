class LogDecorator < Draper::Decorator
  delegate_all

  def summary
    "#{project.name}, #{amount}, #{worked_at}"
  end

  def dom_id
    "log-#{project.id}"
  end

  def worked_at
    log.worked_at.strftime("%A %B %-d, %Y")
  end

  def billable?
    do_not_bill? ? "No" : "Yes"
  end
end
