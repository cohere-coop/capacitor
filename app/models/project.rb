class Project < ActiveRecord::Base
  has_many :logs
  has_many :accounts, through: :logs

  def calculate_capacity_logged
    update(capacity_logged: logs.pluck(:amount).sum)
  end
  def capacity_remaining
    capacity - capacity_logged
  end

end
