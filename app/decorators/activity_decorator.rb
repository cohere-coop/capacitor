require "capacity_converter"

# UI focused methods for Activity objects
class ActivityDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def capacity_remaining
    if activity.capacity == -1
      "Infinity"
    else
      activity.capacity_remaining.to_business_days
    end
  end

  def weekly_burn_rate
    activity.weekly_burn_rate ? activity.weekly_burn_rate.to_business_days : "No days"
  end

  def quality_by_week
    activity.quality_by_week.map do |(_, quality)|
      LogDecorator::QUALITY_PRESENTATION[quality]
    end
  end

  def weekly_capacity_remaining
    if activity.weekly_capacity_remaining > 0
      activity.weekly_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end

  def recent_capacity_remaining
    if activity.recent_capacity_remaining > 0
      activity.recent_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end

  def dom_id
    "activity-#{activity.id}"
  end
end
