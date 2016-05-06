# Entry page used for tracking what was done during their activity
class CheckIn < ActiveRecord::Base
  has_many :logs
  belongs_to :account

  accepts_nested_attributes_for :logs

  default_scope { order(worked_at: :desc) }

  scope :recent, -> (start_at = 7.days.ago) do
    where(worked_at: start_at...Time.zone.now)
  end

  def log_entries_attributes=(log_entries_attributes)
    self.logs_attributes = log_entries_attributes
  end

  def log_entries
    Activity.active.map do |activity|
      logs.find_by(activity: activity) || logs.new(activity: activity)
    end
  end
end
