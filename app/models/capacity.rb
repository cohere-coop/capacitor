class Capacity < ActiveRecord::Base
  belongs_to :project
  belongs_to :worker, class_name: "Account"

  validates :amount, :quality, :worked_at, presence: true

  after_save do
    project.calculate_remaining_capacity
  end
end
