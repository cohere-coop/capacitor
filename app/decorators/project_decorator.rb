require "capacity_converter"

class ProjectDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def per_weekly
    if project.weekly_burn_rate.zero?
      "no expected work"
    else
      "#{weekly_capacity_remaining} capacity remaining this week and #{weekly_burn_rate} per week expected"
    end
  end

  def capacity_remaining
    if project.capacity_remaining == Float::INFINITY
      "infinite work remaining"
    elsif project.capacity_remaining < 0
      "no more work left"
    else
      "#{capacity_remaining_word} of work remaining"
    end
  end

  def capacity_remaining_word
    project.capacity_remaining.to_business_days
  end
  private :capacity_remaining_word

  def capacity_remaining_decimal
    project.capacity_remaining / 8.0
  end
  private :capacity_remaining_decimal

  def weekly_burn_rate
    if project.weekly_burn_rate > 0
      weekly_burn_rate_word
    else
      "no weekly burn rate"
    end
  end

  def weekly_burn_rate_word
    project.weekly_burn_rate.to_business_days
  end
  private :weekly_burn_rate_word

  def weekly_burn_rate_decimal
    project.weekly_burn_rate / 8.0
  end
  private :weekly_burn_rate_decimal

  def weekly_capacity_remaining
    if project.weekly_capacity_remaining > 0
      weekly_capacity_remaining_word
    else
      "zero"
    end
  end

  def weekly_capacity_remaining_word
    project.weekly_capacity_remaining.to_business_days
  end
  private :weekly_capacity_remaining_word

  def weekly_capacity_remaining_decimal
    project.weekly_capacity_remaining / 8.0
  end
  private :weekly_capacity_remaining_decimal
end
