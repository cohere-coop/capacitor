require "capacity_converter"

class ProjectDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def capacity_remaining
    if project.capacity == -1
      "Infinity"
    else
      project.capacity_remaining.to_business_days
    end
  end

  def weekly_burn_rate
    project.weekly_burn_rate ? project.weekly_burn_rate.to_business_days : "No days"
  end

  def quality_by_week
    project.quality_by_week.map do |(_, quality)|
      LogDecorator::QUALITY_PRESENTATION[quality]
    end
  end

  def weekly_capacity_remaining
    if project.weekly_capacity_remaining > 0
      project.weekly_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end

  def recent_capacity_remaining
    if project.recent_capacity_remaining > 0
      project.recent_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end

  def dom_id
    "project-#{project.id}"
  end
end
