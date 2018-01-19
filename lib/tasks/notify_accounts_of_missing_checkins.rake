# frozen_string_literal: true
require "chronic"

namespace :capacitor do
  desc "Notify accounts that they have not checked in for the previous day by noon"
  task notify_accounts_of_missing_checkins: :environment do
    require_dependency "missing_check_in_audit"
    human_current_time = ENV.fetch("OVERRIDE_CURRENT_TIME", "now")
    current_time = Chronic.parse(human_current_time) or
      fail "Couldn't parse #{human_current_time}"
    time_to_remind_for = TimeOfDay.from_time(current_time)
    audit = MissingCheckInAudit.for_day_and_reminder_window(current_time.to_date, time_to_remind_for)
    audit.proceed!
  end
end
