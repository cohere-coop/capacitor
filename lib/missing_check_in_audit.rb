# frozen_string_literal: true

require "time_of_day"
require "time_window"

# Finds and notifies accounts of missing check in from one day ago
class MissingCheckInAudit
  attr_accessor :day_to_audit, :reminder_window

  def self.for_day_and_reminder_window(day_to_audit, reminder_window)
    new(day_to_audit: day_to_audit, reminder_window: TimeWindow(reminder_window))
  end

  def self.for_day(day_to_audit)
    for_day_and_reminder_window(day_to_audit, ("12:00AM".."11:00PM"))
  end

  def initialize(day_to_audit:, reminder_window:)
    self.reminder_window = reminder_window
    self.day_to_audit = day_to_audit
    @state = :initial
  end

  def proceed!
    raise "This object is a one-shot" if @state == :done
    accounts_to_notify.each do |account|
      if account.features.check_in?
        MissingCheckInMailer.missing_check_in(account, day_to_audit).deliver_now
        Rails.logger.info("sent missing check in email to #{account.email} for #{day_to_audit} #{reminder_window}")
      end
    end
    @state = :done
  end

  private def accounts_to_notify
    missing_check_in_window = (day_to_audit.beginning_of_day..day_to_audit.end_of_day)
    Account.all.select do |account|
      account_wants_to_be_notified = reminder_window.include?(account.check_in_reminder_time)
      missing_check_ins = account.check_ins.where(worked_at: missing_check_in_window).empty?

      missing_check_ins && account_wants_to_be_notified
    end
  end
end
