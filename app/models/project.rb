class Project < ActiveRecord::Base
  has_many :logs
  has_many :accounts, through: :logs

  def capacity_logged
    logs.pluck(:amount).sum
  end

  def capacity_remaining
    if capacity == -1
      Float::INFINITY
    else
      capacity - capacity_logged
    end
  end

  def weekly_capacity_remaining
    weekly_burn_rate - logs.recent.billable.pluck(:amount).sum
  end
end
