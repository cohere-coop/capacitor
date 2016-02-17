# Single entry tracking how much time someone spent on an activity
class Log < ActiveRecord::Base
  belongs_to :activity
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  default_scope { order(worked_at: :desc) }

  scope :billable, -> do
    where(do_not_bill: false)
  end

  scope :recent, ->(start_at = 7.days.ago) do
    where(worked_at: start_at..Time.zone.now.to_date)
  end

  scope :from_weeks_ago, ->(weeks_ago = 0) do
    week = weeks_ago.weeks.ago
    where(worked_at: week.beginning_of_week..week.end_of_week)
  end

  scope :up_to_two_months_ago, -> do
    recent(2.months.ago)
  end

  def self.filter(conditions)
    Filter.new(collection: all, conditions: conditions).results
  end
end
