require "capacity_converter"

class LogDecorator < Draper::Decorator
  QUALITY_PRESENTATION = [nil, "😡", "😟", "😐", "😌", "😄"].freeze

  delegate_all
  using CapacityConverter

  def summary
    "#{project.name}, #{amount}, #{worked_at}"
  end

  def amount
    log.amount.to_business_days
  end

  def dom_id
    "log-#{id}"
  end

  def worked_at
    log.worked_at.strftime("%A %B %-d, %Y")
  end

  def billable?
    do_not_bill? ? "No" : "Yes"
  end

  def smiley_face
    QUALITY_PRESENTATION[log.quality]
  end
end
