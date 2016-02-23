# Activities that People Track Energy/Time against
class Activity < ActiveRecord::Base
  has_many :logs
  has_many :accounts, through: :logs

  has_many :teams_activities
  has_many :teams, through: :teams_activities

  validates :name, :capacity, :weekly_burn_rate, presence: true

  scope :active, lambda {
    where(active: true)
  }

  def capacity_logged
    logs.billable.pluck(:amount).sum
  end

  def capacity_remaining
    if capacity == -1
      Float::INFINITY
    else
      capacity - capacity_logged
    end
  end

  def weekly_capacity_remaining
    weekly_burn_rate - logs.from_weeks_ago(0).billable.pluck(:amount).sum
  end

  def recent_capacity_remaining
    weekly_burn_rate - logs.recent.billable.pluck(:amount).sum
  end

  def quality_by_week
    logs_by_week = logs.up_to_two_months_ago.group_by { |l| l.worked_at.beginning_of_week }

    logs_by_week.each_with_object({}) do |(beginning_of_week, logs), weeks|
      qualities = logs.map(&:quality)
      weeks[beginning_of_week] = (qualities.reduce(:+).to_f / qualities.length).round
    end
  end
end
