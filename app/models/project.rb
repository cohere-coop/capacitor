class Project < ActiveRecord::Base
  has_many :logs
  has_many :accounts, through: :logs

  def calculate_capacity_logged
    update(capacity_logged: logs.pluck(:amount).sum)
  end

  def capacity_remaining
    if capacity == -1
      Float::INFINITY
    else
      capacity - capacity_logged
    end
  end

  def capacity_remaining_this_week
    weekly_burn_rate - logs.recent.pluck(:amount).sum
  end
end
