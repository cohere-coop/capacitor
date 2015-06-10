class Log < ActiveRecord::Base
  belongs_to :project
  belongs_to :account

  validates :amount, presence: true
  validates :quality, presence: true
  validates :worked_at, presence: true
  validates :account, presence: true

  scope :weekly, ->(distance = 0) do
    start_at = Date.today.beginning_of_week - distance.weeks
    end_at = Date.today.end_of_week - distance.weeks
    order(worked_at: :desc).where(worked_at: start_at..end_at)
  end

  scope :billable, -> do
    where(do_not_bill: false)
  end

  scope :recent, ->(start_at = 7.days.ago) do
    order(worked_at: :desc).where(worked_at: start_at..Date.today)
  end

  scope :for_project, ->(project) do
    where(project_id: project)
  end
end
