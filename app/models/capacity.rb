class Capacity < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  valdiates :worked_at, presence: true
  validates :account, presence: true

  after_save do
    project.calculate_remaining_capacity
  end
end
