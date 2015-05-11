class Capacity < ActiveRecord::Base
  belongs_to :project
  belongs_to :worker, class_name: "Account"

  validates :amount, :quality, :worked_at, :do_not_bill, presence: true

  after_create :update_capacity_remaining


  def update_capacity_remaining
    self.project.capacity_remaining = self.project.total_capacity_owed

    capacity_used = self.project.capacity_used += self.amount

    capacity_remaining = self.project.capacity_remaining -= capacity_used

    self.project.update_attributes(capacity_remaining: capacity_remaining, capacity_used: capacity_used)
  end

end