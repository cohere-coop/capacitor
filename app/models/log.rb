class Log < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  scope :recent, lambda {
    start_at = 7.days.ago
    end_at = Time.zone.today
    order(worked_at: :desc).where(worked_at: start_at..end_at)
  }

  scope :billable, lambda {
    where(do_not_bill: false)
  }
end
