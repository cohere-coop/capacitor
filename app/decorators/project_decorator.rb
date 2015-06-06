require "capacity_converter"

class ProjectDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def per_weekly
    if any_burn_rate?
      "no expected work"
    else
      "#{weekly_capacity_remaining} capacity remaining this week and #{weekly_burn_rate} per week expected"
    end
  end

  def capacity_remaining
    if infinte_capacity_remaining?
      "infinite work remaining"
    elsif no_capacity_remaining?
      "no more work left"
    else
      "#{project.capacity_remaining.to_business_days} of work remaining"
    end
  end

  def weekly_burn_rate
    if any_burn_rate?
      project.weekly_burn_rate.to_business_days
    else
      "no weekly burn rate"
    end
  end

  def weekly_capacity_remaining
    if any_weekly_remaining?
      project.weekly_capacity_remaining.to_business_days
    else
      "zero"
    end
  end

  def capacity_remaining_value
    project.capacity_remaining
  end
  private :capacity_remaining_value

  def weekly_burn_rate_value
    project.weekly_burn_rate
  end
  private :weekly_burn_rate_value

  def weekly_capacity_remaining_value
    project.weekly_capacity_remaining
  end
  private :weekly_capacity_remaining_value

  def infinte_capacity_remaining?
    project.capacity_remaining == Float::INFINITY
  end
  private :infinte_capacity_remaining?

  def no_capacity_remaining?
    project.capacity_remaining < 0
  end
  private :no_capacity_remaining?

  def any_burn_rate?
    project.weekly_burn_rate > 0
  end
  private :any_burn_rate?

  def any_weekly_remaining?
    project.weekly_capacity_remaining > 0
  end
  private :any_weekly_remaining?
end
