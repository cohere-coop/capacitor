# frozen_string_literal: true

# Entry page used for tracking what was done during their activity
class CheckIn < ActiveRecord::Base
  has_many :logs
  belongs_to :account

  validates :account, presence: true
  validates :worked_at, presence: true

  accepts_nested_attributes_for :logs

  default_scope { order(worked_at: :desc) }

  scope(:recent, ->(start_at = 7.days.ago.beginning_of_day) do
    where(worked_at: start_at...Time.zone.now.end_of_day)
  end)

  def log_entries_attributes=(log_entries_attributes)
    @log_entries_attributes = self.logs_attributes = log_entries_attributes
  end

  attr_reader :log_entries_attributes
  def log_entries
    find_or_build_logs_for_each_activity
    update_newly_created_logs_with_attrs

    logs
  end

  private def find_or_build_logs_for_each_activity
    account.activities.active.map do |activity|
      logs.find_by(activity: activity) ||
        logs.detect { |l| l.activity == activity } ||
        logs.new(activity: activity)
    end
  end

  private def update_newly_created_logs_with_attrs
    log_entries_attributes&.each do |_, attrs|
      log = logs.detect { |entry| entry.activity_id == attrs[:activity_id] }
      log.update(attrs)
    end
  end
end
