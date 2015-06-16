require "capacity_converter"

class ProjectDecorator < Draper::Decorator
  QUALITY_PRESENTATION = ["😡","😟","😐","😌","😄"]

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
    project.quality_by_week.map { |week_with_quality|
      p week_with_quality
      _, quality = week_with_quality
        QUALITY_PRESENTATION[quality]
    }
  end

  def weekly_capacity_remaining
    if project.weekly_capacity_remaining > 0
      project.weekly_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end
end
