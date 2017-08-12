# frozen_string_literal: true

require "capacity_converter"

# UI focused methods for Activity objects
class ActivityDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def summary
    summary = name
    summary += "(#{capacity_remaining})" if owner.features.bills_time? && activity.capacity != -1
    summary
  end

  def capacity_remaining
    "#{activity.capacity_remaining} hours" if activity.capacity != -1
  end

  def dom_id
    "activity-#{activity.id}"
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
    if activity.weekly_capacity_remaining.positive?
      activity.weekly_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end

  def recent_capacity_remaining
    if activity.recent_capacity_remaining.positive?
      activity.recent_capacity_remaining.to_business_days
    else
      "No capacity"
    end
  end
end
