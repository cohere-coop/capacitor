class Log < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  after_save do
    project.calculate_capacity_logged
  end

  scope :recent, lambda {
    order(:worked_at).where("worked_at >= ?", 7.days.ago)
  }
end
